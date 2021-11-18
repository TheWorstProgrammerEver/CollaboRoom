
import SwiftUI

struct ContentView : View {
    
    @EnvironmentObject private var appState: CollaborationParticipantAppState
    
    var body: some View {
        NavigationView {
            JoinScreenViewContainer()
        }
    }
}
