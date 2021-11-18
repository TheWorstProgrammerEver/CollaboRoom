
import MultipeerConnectivity

extension Discoverer : MCNearbyServiceBrowserDelegate {
    
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String : String]?) {
            
            onFound(peerID)
        }
    
    func browser(
        _ browser: MCNearbyServiceBrowser,
        lostPeer peerID: MCPeerID) {
            
            onLost(peerID)
        }
}
