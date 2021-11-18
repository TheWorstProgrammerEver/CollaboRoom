
import Combine

class StartScreenViewModel : ObservableObject {
    
    @Published var hostIsActive: Bool = false
    
    private let appState: CollaborationHostAppState
    
    private var subs: Set<AnyCancellable> = .init()
    
    init(_ appState: CollaborationHostAppState) {
        self.appState = appState
        
        appState
            .$host
            .map { $0 != nil }
            .assign(to: &$hostIsActive)
        
        $hostIsActive
            .removeDuplicates()
            .dropFirst()
            .sink { v in
                if !v { appState.endCollaboration()}
            }
            .store(in: &subs)
    }
    
    func start() {
        appState.startCollaboration()
    }
    
    func stop() {
        appState.endCollaboration()
    }
}
