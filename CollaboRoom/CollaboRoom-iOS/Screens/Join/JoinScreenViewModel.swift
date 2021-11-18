
import MultipeerConnectivity
import Combine

class JoinScreenViewModel : ObservableObject {
    
    @Published private(set) var servers: [ServerViewModel] = []
    @Published var participantIsActive: Bool = false
    
    private let appState: CollaborationParticipantAppState
    
    private var subs: Set<AnyCancellable> = .init()
    
    init(_ appState: CollaborationParticipantAppState) {
        self.appState = appState
        
        appState
            .$servers
            .map { cs in
                cs.map { s in
                    .init(
                        id: s,
                        displayName: s.displayName,
                        connect: { appState.connectToServer(s) })
                }
            }
            .assign(to: &$servers)
        
        appState
            .$participant
            .map { $0 != nil }
            .assign(to: &$participantIsActive)
        
        $participantIsActive
            .dropFirst()
            .removeDuplicates()
            .sink { v in
                if !v { appState.disconnectFromServer() }
            }
            .store(in: &subs)
    }
    
    func start() {
        appState.startDiscoveringServers()
    }
    
    func stop() {
        appState.stopDiscoveringServers()
    }
    
    func disconnect() {
        appState.disconnectFromServer()
    }
}

struct ServerViewModel {
    var id: MCPeerID
    var displayName: String
    var connect: () -> Void
}
