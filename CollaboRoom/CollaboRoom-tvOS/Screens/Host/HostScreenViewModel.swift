
import SwiftUI

class HostScreenViewModel : ObservableObject {
    
    @Published private(set) var stickies: [StickyViewModel] = []
    @Published private(set) var participants: [String] = []
    @Published private(set) var isInTimeout: Bool = false
    @Published private(set) var announcement: String? = nil
    
    private let host: CollaborationHost
    
    init(_ host: CollaborationHost) {
        
        self.host = host
        
        host
            .$stickies
            .map { cs in
                cs.map { s in
                    .init(
                        id: s.id,
                        text: s.text,
                        image: ({
                            if let data = s.image {
                                return .init(data: data)!
                            }
                            return nil
                        })())
                }
            }
            .assign(to: &$stickies)
        
        host
            .$participants
            .assign(to: &$participants)
        
        host
            .$isInTimeout
            .assign(to: &$isInTimeout)
        
        host
            .announcementPublisher
            .map { $0 as String? }
            .assign(to: &$announcement)
    }
    
    func resume() {
        host.resume()
    }
    
    func clearAnnouncement() {
        announcement = nil
    }
}

struct StickyViewModel {
    var id: UUID
    var text: String
    var image: UIImage?
}
