
import SwiftUI

struct RootView : View {
    
    @StateObject private var appState: CollaborationParticipantAppState = .init(Host.current().localizedName!)
    
    var body: some View {
        ContentView()
            .environmentObject(appState)
    }
}
