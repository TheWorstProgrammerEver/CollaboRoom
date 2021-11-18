
import MultipeerConnectivity

class Server : NSObject {
    
    private let advertiser: MCNearbyServiceAdvertiser
    
    let peerId: MCPeerID
    var sessions: [MCSession] = []
    let onMessageReceived: (Message) -> Void
    let onClientConnected: (MCPeerID) -> Void
    let onClientDisconnected: (MCPeerID) -> Void
    
    init(
        name: String,
        onClientConnected: @escaping (MCPeerID) -> Void,
        onMessageReceived: @escaping (Message) -> Void,
        onClientDisconnected: @escaping (MCPeerID) -> Void) {
            
            peerId = .init(displayName: name)
            advertiser = .init(peer: peerId, discoveryInfo: nil, serviceType: serviceType)
            
            self.onClientConnected = onClientConnected
            self.onMessageReceived = onMessageReceived
            self.onClientDisconnected = onClientDisconnected
            
            super.init()
            
            advertiser.delegate = self
        }
    
    func start() {
        advertiser.startAdvertisingPeer()
    }
    
    func stop() {
        advertiser.stopAdvertisingPeer()
        sessions.forEach { s in
            s.disconnect()
        }
    }
    
    func broadcast(_ message: Message) {
        
        let payload = try! JSONEncoder().encode(message)
        
        sessions.forEach { s in
            do {
                try s.send(payload, toPeers: s.connectedPeers, with: .reliable)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
