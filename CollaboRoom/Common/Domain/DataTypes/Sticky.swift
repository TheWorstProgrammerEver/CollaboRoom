
import Foundation

struct Sticky : Codable {
    var id: UUID = .init()
    var text: String
    var image: Data?
}
