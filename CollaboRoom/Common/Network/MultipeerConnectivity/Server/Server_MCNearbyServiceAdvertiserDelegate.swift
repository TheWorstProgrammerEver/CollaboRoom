
import MultipeerConnectivity

extension Server : MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void) {
            
            // One session per peer because apparently it's buggy trying to support multiple. 🤷‍♀️
            let existing = sessions.first { s in
                s.connectedPeers.contains(peerID)
            }
            
            guard existing == nil else { return }
            
            let session = MCSession(peer: peerId, securityIdentity: nil, encryptionPreference: .required)
            session.delegate = self
            
            invitationHandler(true, session)
            sessions.append(session)
        }
}
