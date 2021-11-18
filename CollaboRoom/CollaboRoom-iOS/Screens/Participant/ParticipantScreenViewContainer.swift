
import SwiftUI

struct ParticipantScreenViewContainer : View {
    
    @EnvironmentObject private var appState: CollaborationParticipantAppState
    
    var body: some View {
        if appState.participant == nil {
            Text("Join a CollaboRoom")
        } else {
            ViewContainer(
                ParticipantScreenViewModel(appState.participant!),
                ParticipantScreenView.init)
                #if !os(macOS)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                #endif
                .navigationTitle(appState.participant!.hostName)
        }
    }
}
