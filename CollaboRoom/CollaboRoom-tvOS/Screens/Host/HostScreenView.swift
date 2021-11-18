
import SwiftUI

struct HostScreenView : View {
    
    @ObservedObject var viewModel: HostScreenViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text("\(viewModel.stickies.count) stickies").bold()
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.stickies, id: \.id) { s in
                        Button(action: { /* // TODO: RH - Maybe full-screen view? */ }) {
                            ZStack {
                                if let image = s.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .clipped()
                                }
                                if !s.text.isEmpty {
                                    Text(s.text)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: 300)
                                        .frame(minHeight: 300, maxHeight: 600)
                                }
                            }
                        }
                        .buttonStyle(CardButtonStyle())
                    }
                }
                .padding(.vertical, 20)
            }
            .frame(maxHeight: .infinity)
            
            VStack(spacing: 10) {
                Text("\(viewModel.participants.count) Participants").bold()
                HStack {
                    ForEach(viewModel.participants, id: \.self) { p in
                        Text(p)
                    }
                }
            }
        }
        .alert(
            "Announcement",
            isPresented: .constant(viewModel.announcement != nil),
            actions: { Button(action: viewModel.clearAnnouncement) { Text("Clear") } },
            message: {
                Text(viewModel.announcement ?? "")
            })
        .alert(
            "Timeout",
            isPresented: .constant(viewModel.isInTimeout),
            actions: { Button(action: viewModel.resume) { Text("Resume") } },
            message: {
                Text("Let's take a break.")
            })
    }
}

