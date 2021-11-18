
import MultipeerConnectivity

extension Server : MCSessionDelegate {
    
    public func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState) {
            switch state {
            case .connected: onClientConnected(peerID)
            case .notConnected: onClientDisconnected(peerID)
            default: return
            }
        }
    
    public func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID) {
            
            session.nearbyConnectionData(forPeer: peerID) { data, error in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data else {
                    // No data, despite no error... 🤷‍♀️
                    return
                }
                
                session.connectPeer(peerID, withNearbyConnectionData: data)
            }

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
