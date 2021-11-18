
import SwiftUI
import MultipeerConnectivity

struct JoinScreenViewContainer : View {
    
    @EnvironmentObject private var appState: CollaborationParticipantAppState
    
    var body: some View {
        ViewContainer(
            JoinScreenViewModel(appState),
            JoinScreenView.init)
            .navigationTitle("Join")
    }
}
