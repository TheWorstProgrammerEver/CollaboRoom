
import Foundation

struct Message : Codable {
    var id: UUID = .init()
    var timestamp: Date = .init()
    var data: Data
}
