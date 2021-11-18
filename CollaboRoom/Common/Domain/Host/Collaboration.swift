
import Combine

class Host : ObservableObject {
    
    @Published private(set) var stickies: [Sticky] = []
    @Published private(set) var participants: [String] = []
    @Published private(set) var isInTimeout: Bool = false
    
    private let announcementSubject: PassthroughSubject<String, Never>
    let announcementPublisher: AnyPublisher<String, Never>
    
    init() {
        self.announcementSubject = .init()
        self.announcementPublisher = announcementSubject.eraseToAnyPublisher()
    }
    
    func add(sticky: Sticky) {
        stickies.append(sticky)
    }
    
    func add(participant: String) {
        participants.append(participant)
    }
    
    func remove(participant: String) {
        participants.removeAll { participant == $0 }
    }
    
    func timeout() {
        isInTimeout = true
    }
    
    func resume() {
        isInTimeout = false
    }
    
    func jellyfish() {
        announcementSubject.send("Jellyfish!")
    }
    
    func clear() {
        stickies.removeAll()
    }
}

