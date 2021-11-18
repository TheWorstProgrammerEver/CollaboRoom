
import SwiftUI

struct StartScreenViewContainer : View {
    
    @EnvironmentObject private var appState: CollaborationHostAppState
    
    var body: some View {
        ViewContainer(
            StartScreenViewModel(appState),
            StartScreenView.init)
            .navigationTitle("CollaboRoom")
    }
}
