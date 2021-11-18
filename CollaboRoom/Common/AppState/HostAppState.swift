import Combine
import MultipeerConnectivity

class CollaborationHostAppState : ObservableObject {
    
    @Published private(set) var host: CollaborationHost? = nil
    
    private let name: String
    
    private var server: Server!
    
    private let participantActions: PassthroughSubject<CollaborationParticipantAction, Never> = .init()
    
    private var subs: Set<AnyCancellable> = .init()
    
    init(_ name: String) {
        self.name = name
    }
    
    func startCollaboration() {
        server?.stop()
        server = .init(
            name: name,
            onClientConnected: onClientConnected,
            onMessageReceived: onMessageReceivedFromClient,
            onClientDisconnected: onClientDisconnected)
        server.start()
        
        host = .init()
        
        // Sync me with participants
        // Clients -> Server
        participantActions
            .receive(on: RunLoop.main)
            .sink { [weak self] a in
                switch a {
                case .announcement(_): return
                case .addSticky(let s): self?.host?.add(sticky: s)
                case .join(let p): self?.host?.add(participant: p)
                case .leave(let p): self?.host?.remove(participant: p)
                case .timeout: self?.host?.timeout()
                case .resume: self?.host?.resume()
                case .jellyfish: self?.host?.jellyfish()
                }
            }
            .store(in: &subs)
        
        // Sync participants with me
        // Server -> Clients
        host!
            .$isInTimeout
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] v in
                self?.sendActionToClients(v ? .timeout : .resume)
            }
            .store(in: &subs)
        
        host!
            .announcementPublisher
            .sink { [weak self] a in
                self?.sendActionToClients(.announcement(a))
            }
            .store(in: &subs)
    }
    
    func endCollaboration() {
        subs.forEach { s in s.cancel() }
        subs.removeAll()
        host = nil
        
        server?.stop()
        server = nil
    }
    
    func sendActionToClients(_ action: CollaborationHostAction) {
        let message: Message = .init(data: try! JSONEncoder().encode(action))
        
        server.broadcast(message)
    }
    
    private func onClientConnected(_ peer: MCPeerID) {
        participantActions.send(.join(peer.displayName))
    }
    
    private func onMessageReceivedFromClient(_ message: Message) {
        let action = try! JSONDecoder().decode(CollaborationParticipantAction.self, from: message.data)
        
        print("Message received from Client")
        print(action)
        
        participantActions.send(action)
    }
    
    private func onClientDisconnected(_ peer: MCPeerID) {
        participantActions.send(.leave(peer.displayName))
    }
}
