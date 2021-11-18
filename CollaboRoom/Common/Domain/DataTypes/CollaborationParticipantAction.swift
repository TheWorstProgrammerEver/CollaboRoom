
import Foundation

enum CollaborationParticipantAction : Codable {
    
    case join(String)
    case leave(String)
    
    case announcement(String)
    
    case addSticky(Sticky)
    
    case timeout
    case resume
    case jellyfish
}
