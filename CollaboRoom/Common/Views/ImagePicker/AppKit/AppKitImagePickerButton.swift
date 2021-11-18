
import SwiftUI

struct AppKitImagePickerButton : View {
    
    var label: String
    @Binding var image: NSImage?
    
    var body: some View {
        
        VStack {
            if let i = image {
                Image(nsImage: i)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 7.5))
            }
            
            HStack {
                Button(label) {
                    let openPanel = NSOpenPanel()
                    openPanel.prompt = label
                    openPanel.allowsMultipleSelection = false
                    openPanel.canChooseDirectories = false
                    openPanel.canCreateDirectories = false
                    openPanel.canChooseFiles = true
                    openPanel.allowedContentTypes = [.png, .jpeg]
                    openPanel.begin { (result) -> Void in
                        if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                            let url = openPanel.url!
                            let data = try! Data(contentsOf: url)
                            let image = NSImage(data: data)
                            DispatchQueue.main.async {
                                self.image = image
                            }
                        }
                    }
                }
                if image != nil {
                    Button("Clear") {
                        self.image = nil
                    }
                }
            }
            
        }
    }
}
