
import SwiftUI

struct StartScreenView : View {
    
    @ObservedObject var viewModel: StartScreenViewModel
    
    var body: some View {
        VStack {
            Button(action: viewModel.start) {
                Text("Start collaborating!")
            }
        }
        .background(ZStack {
            NavigationLink(
                "Collaboration",
                isActive: $viewModel.hostIsActive,
                destination: { HostScreenViewContainer() })
        }.hidden())
    }
}
