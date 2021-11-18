
import Foundation

enum CollaborationHostAction : Codable {
    case announcement(String)
    case timeout
    case resume
    case jellyfish
}
