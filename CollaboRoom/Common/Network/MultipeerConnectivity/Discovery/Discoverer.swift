
import MultipeerConnectivity

class Discoverer : NSObject {
    
    private let peerId: MCPeerID
    private let browser: MCNearbyServiceBrowser
    
    let onFound: (MCPeerID) -> Void
    let onLost: (MCPeerID) -> Void
    
    init(
        name: String,
        onFound: @escaping (MCPeerID) -> Void,
        onLost: @escaping (MCPeerID) -> Void) {
            
            peerId = .init(displayName: name)
            browser = .init(peer: peerId, serviceType: serviceType)

            self.onFound = onFound
            self.onLost = onLost
            
            super.init()
            
            browser.delegate = self
        }
    
    func start() {
        browser.startBrowsingForPeers()
    }
    
    func createClient(
        _ serverPeerId: MCPeerID,
        onMessageReceived: @escaping (Message) -> Void,
        onMessageSendError: @escaping (Message, Error) -> Void) -> Client {
            
            let session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
            
            browser.invitePeer(serverPeerId, to: session, withContext: nil, timeout: 10)
            
            return .init(
                session,
                onMessageReceived: onMessageReceived,
                onMessageSendError: onMessageSendError)
        }
    
    func stop() {
        browser.stopBrowsingForPeers()
    }
}
