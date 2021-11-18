
import SwiftUI

#if os(macOS)

struct ImagePickerButton : View {
    
    @Binding var image: NSImage?
    
    var body: some View {
        AppKitImagePickerButton(label: "Image", image: $image)
    }
}

#else

struct ImagePickerButton : View {
    
    @Binding var image: UIImage?
    
    var body: some View {
        UIKitImagePickerButton(label: "Image", image: $image)
            .frame(maxHeight: 300)
    }
}

#endif
