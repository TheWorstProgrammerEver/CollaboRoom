
import SwiftUI

struct RootView: View {
    
    @StateObject private var appState: CollaborationParticipantAppState = .init(UIDevice.current.name)
    
    var body: some View {
        ContentView()
            .environmentObject(appState)
    }
}
