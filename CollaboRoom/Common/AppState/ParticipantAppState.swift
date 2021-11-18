
import Combine
import MultipeerConnectivity

class CollaborationParticipantAppState : ObservableObject {
    
    @Published private(set) var servers: [MCPeerID] = []
    
    @Published private(set) var participant: CollaborationParticipant? = nil
    
    private let name: String
    
    private var discoverer: Discoverer!
    
    private var client: Client!
    
    private let hostActions: PassthroughSubject<CollaborationHostAction, Never> = .init()
    
    private var subs: Set<AnyCancellable> = .init()
    
    init(_ name: String) {
        self.name = name
    }
    
    func startDiscoveringServers() {
        discoverer?.stop()
        
        discoverer = .init(
            name: name,
            onFound: onFoundServer,
            onLost: onLostServer)
        
        discoverer.start()
    }
    
    private func onFoundServer(_ id: MCPeerID) {
        servers.append(id)
    }
    
    private func onLostServer(_ id: MCPeerID) {
        servers.removeAll { id == $0 }
    }
    
    func stopDiscoveringServers() {
        discoverer?.stop()
        servers = []
        discoverer = nil
    }
    
    func connectToServer(_ id: MCPeerID) {
        client?.stop()
        
        client = discoverer.createClient(
            id,
            onMessageReceived: onMessageReceivedFromServer,
            onMessageSendError: onMessageSendToServerError)
        
        participant = .init(
            hostName: id.displayName,
            onAddSticky: sendStickyToServer,
            onLeave: disconnectFromServer,
            onProposeTimeout: sendTimeoutProposalToServer,
            onProposeResume: sendResumeProposalToServer,
            onJellyfish: sendJellyfishToServer)
        
        hostActions
            .receive(on: RunLoop.main)
            .sink { [weak self] a in
                switch a {
                case .announcement(let m): self?.participant?.announce(m)
                case .timeout: self?.participant?.timeout()
                case .resume: self?.participant?.resume()
                case .jellyfish: self?.participant?.jellyfish()
                }
            }
            .store(in: &subs)
    }
    
    func disconnectFromServer() {
        participant = nil
        
        client?.stop()
        client = nil
    }
    
    private func sendStickyToServer(_ sticky: Sticky) {
        sendActionToServer(.addSticky(sticky))
    }
    
    private func sendTimeoutProposalToServer() {
        sendActionToServer(.timeout)
    }
    
    private func sendResumeProposalToServer() {
        sendActionToServer(.resume)
    }
    
    private func sendJellyfishToServer() {
        sendActionToServer(.jellyfish)
    }
    
    private func sendActionToServer(_ action: CollaborationParticipantAction) {
        let message: Message = .init(data: try! JSONEncoder().encode(action))
        
        client.send(message)
    }
    
    private func onMessageReceivedFromServer(_ message: Message) {
        let action = try! JSONDecoder().decode(CollaborationHostAction.self, from: message.data)
        
        print("Message received from Server")
        print(action)
        
        hostActions.send(action)
    }
    
    private func onMessageSendToServerError(_ message: Message, _ error: Error) {
        let failedAction = try! JSONDecoder().decode(CollaborationParticipantAction.self, from: message.data)
        
        print("Message failed to send to Server")
        print(error)
        print(failedAction)
        
        // Don't care that much, really.
    }
    
}
