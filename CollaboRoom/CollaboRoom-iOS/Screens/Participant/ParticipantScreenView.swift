
import SwiftUI

struct ParticipantScreenView : View {
    
    @ObservedObject var viewModel: ParticipantScreenViewModel
    
    var body: some View {
        StickyEditor(sticky: $viewModel.sticky)
            .disabled(viewModel.isInTimeout)
            .alert(
                "Announcement",
                isPresented: .init(
                    get: { viewModel.announcement != nil },
                    set: { v in if !v { viewModel.clearAnnouncement() } }),
                actions: { },
                message: {
                    Text(viewModel.announcement ?? "")
                })
            .alert(
                "Timeout",
                isPresented: $viewModel.showTimeoutAnnouncement,
                actions: { },
                message: {
                    Text("Timeout!")
                })
            .toolbar {
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: viewModel.addSticky) {
                        Text("Add")
                    }
                    .disabled(
                        !viewModel.sticky.isValid ||
                        viewModel.isInTimeout)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: viewModel.leave) {
                        Text("Leave")
                    }
                }
                
                ToolbarItemGroup(placement: toolbarPlacement) {
                    
                    Button(action: viewModel.jellyfish) {
                        Label(
                            "Jellyfish",
                            systemImage: "exclamationmark.bubble.fill")
                    }
                    
                    Button(action: viewModel.isInTimeout
                           ? viewModel.resume
                           : viewModel.timeout) {
                        Label(
                            viewModel.isInTimeout
                            ? "Resume"
                            : "Timeout",
                            systemImage: viewModel.isInTimeout
                            ? "play.fill"
                            : "pause.fill")
                    }
                }
            }
    }
    
    private var toolbarPlacement: ToolbarItemPlacement {
        #if os(macOS)
        .automatic
        #else
        .bottomBar
        #endif
    }
}

struct StickyEditor : View {
    
    @Binding var sticky: NewSticky
    
    var body: some View {
        
        Form {
            Section(
                header: VStack {
                    ImagePickerButton(image: $sticky.image)
                }) {
                    BetterTextEditor(label: "Text", text: $sticky.text, placeholder: "Write something...")
                }
        }
    }
}

struct NewSticky {
    var text: String = ""
    
    #if os(macOS)
    var image: NSImage? = nil
    #else
    var image: UIImage? = nil
    #endif
    
    var isValid: Bool { !text.isEmpty || image != nil }
}
