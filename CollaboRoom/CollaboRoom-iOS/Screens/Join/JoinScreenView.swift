
import SwiftUI

struct JoinScreenView : View {
    
    @ObservedObject var viewModel: JoinScreenViewModel
    
    var body: some View {
        List(viewModel.servers, id: \.id) { s in
            Button(action: s.connect) {
                Text(s.displayName)
            }
            #if os(macOS)
            .buttonStyle(PlainButtonStyle())
            #endif
        }
        .background(ZStack {
            NavigationLink(
                "Participate",
                isActive: $viewModel.participantIsActive,
                destination: { ParticipantScreenViewContainer() })
        }.hidden())
        .onAppear {
            viewModel.start()
        }
        .onDisappear {
            viewModel.stop()
        }
    }
}
