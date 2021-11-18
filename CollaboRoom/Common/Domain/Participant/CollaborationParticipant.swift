
import Combine

class CollaborationParticipant : ObservableObject {
    
    let hostName: String
    
    @Published private(set) var isInTimeout: Bool = false
    @Published private(set) var announcement: String? = nil
    
    let onAddSticky: (Sticky) -> Void
    let onLeave: () -> Void
    let onProposeTimeout: () -> Void
    let onProposeResume: () -> Void
    let onJellyfish: () -> Void
    
    init(
        hostName: String,
        onAddSticky: @escaping (Sticky) -> Void,
        onLeave: @escaping () -> Void,
        onProposeTimeout: @escaping () -> Void,
        onProposeResume: @escaping () -> Void,
        onJellyfish: @escaping () -> Void
    ) {
        self.hostName = hostName
        self.onAddSticky = onAddSticky
        self.onLeave = onLeave
        self.onProposeTimeout = onProposeTimeout
        self.onProposeResume = onProposeResume
        self.onJellyfish = onJellyfish
    }
    
    func add(_ sticky: Sticky) {
        onAddSticky(sticky)
    }
    
    func leave() {
        onLeave()
    }
    
    func proposeTimeout() {
        onProposeTimeout()
    }
    
    func proposeResume() {
        onProposeResume()
    }
    
    func proposeJellyfish() {
        onJellyfish()
    }
    
    func announce(_ message: String) {
        announcement = message
    }
    
    func clearAnnouncement() {
        announcement = nil
    }
    
    func toggleTimeout() {
        isInTimeout.toggle()
    }
    
    func timeout() {
        isInTimeout = true
    }
    
    func resume() {
        isInTimeout = false
    }
    
    func jellyfish() {
        announcement = "JELLYFISH!"
    }
    
}
