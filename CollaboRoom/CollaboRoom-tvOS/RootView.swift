
import SwiftUI

struct RootView : View {
    
    @StateObject private var appState: CollaborationHostAppState = .init(UIDevice.current.name)
    
    var body: some View {
        ContentView()
            .environmentObject(appState)
    }
}
