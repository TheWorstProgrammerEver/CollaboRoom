
import MultipeerConnectivity

class Client : NSObject {
    
    private let session: MCSession
    private let onMessageSendError: (Message, Error) -> Void
    
    let onMessageReceived: (Message) -> Void
    
    init(
        _ session: MCSession,
        onMessageReceived: @escaping (Message) -> Void,
        onMessageSendError: @escaping (Message, Error) -> Void) {
            
            self.session = session
            self.onMessageReceived = onMessageReceived
            self.onMessageSendError = onMessageSendError
            
            super.init()
            
            session.delegate = self
        }
    
    func send(_ message: Message) {
        
        let payload = try! JSONEncoder().encode(message)
        
        do {
            try session.send(payload, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            onMessageSendError(message, error)
        }
    }
    
    func stop() {
        session.disconnect()
    }
}
