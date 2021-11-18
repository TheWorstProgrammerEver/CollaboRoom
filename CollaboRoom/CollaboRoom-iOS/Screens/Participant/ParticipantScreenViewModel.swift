
import SwiftUI

class ParticipantScreenViewModel : ObservableObject {
    
    @Published var sticky: NewSticky = .init()
    
    @Published var announcement: String? = nil
    @Published var isInTimeout: Bool = false
    
    @Published var showTimeoutAnnouncement: Bool = false
    
    private let participant: CollaborationParticipant
    
    init(_ participant: CollaborationParticipant) {
        self.participant = participant
        
        participant
            .$announcement
            .assign(to: &$announcement)
        
        participant
            .$isInTimeout
            .assign(to: &$isInTimeout)
        
        participant
            .$isInTimeout
            .removeDuplicates()
            .filter { $0 }
            .assign(to: &$showTimeoutAnnouncement)
    }
    
    func addSticky() {
        participant.add(
            .init(
                text: sticky.text,
                image: sticky.image?.resize(maxDimension: 500)))
        
        sticky = .init()
    }
    
    func leave() {
        participant.leave()
    }
    
    func jellyfish() {
        participant.proposeJellyfish()
    }
    
    func timeout() {
        participant.proposeTimeout()
    }
    
    func resume() {
        participant.proposeResume()
    }
    
    func clearAnnouncement() {
        announcement = nil
    }
}
