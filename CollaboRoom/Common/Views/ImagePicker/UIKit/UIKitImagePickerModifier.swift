
import SwiftUI

struct ImagePickerModifier : ViewModifier {
    
    @Binding var isPresented: Bool
    
    var onSelect: (UIImage) -> Void
    
    func body(content: Content) -> some View {
        content.sheet(isPresented: $isPresented) {
            ImagePicker(onSelect: onSelect)
        }
    }
}

extension View {
    func imagePicker(isPresented: Binding<Bool>, onSelect: @escaping (UIImage) -> Void) -> some View {
        modifier(ImagePickerModifier(isPresented: isPresented, onSelect: onSelect))
    }
}
