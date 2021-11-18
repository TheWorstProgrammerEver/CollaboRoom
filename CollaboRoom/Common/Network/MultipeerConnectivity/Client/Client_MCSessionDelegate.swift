
import MultipeerConnectivity

extension Client : MCSessionDelegate {
    
    public func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState) {
            // Don't care for this demo.
            // Assume success all the time.
        }
    
    public func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID) {
            
            let message = try! JSONDecoder().decode(Message.self, from: data)
            
            onMessageReceived(message)
        }
    
    public func session(
        _ session: MCSession,
        didReceive stream: InputStream,
        withName streamName: String,
        fromPeer peerID: MCPeerID) { }
    
    public func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress) { }
    
    public func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?) { }
}
