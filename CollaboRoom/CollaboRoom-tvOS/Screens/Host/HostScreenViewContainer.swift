
import SwiftUI

struct HostScreenViewContainer : View {
    
    @EnvironmentObject private var appState: CollaborationHostAppState
    
    var body: some View {
        ViewContainer(
            HostScreenViewModel(appState.host!),
            HostScreenView.init)
            .navigationTitle("Collaboration")
    }
}
