
import SwiftUI

struct UIKitImagePickerButton : View {
    
    var label: String
    @Binding var image: UIImage?
    
    @State private var presentingImagePicker: Bool = false
    @State private var presentingConfirmation: Bool = false
    
    var body: some View {
        VStack {
            if let i = image {
                Button(action: { presentingConfirmation = true }) {
                    Image(uiImage: i)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 7.5))
                }
                .confirmationDialog(
                    label,
                    isPresented: $presentingConfirmation) {
                        Button(
                            role: .none,
                            action: { presentingImagePicker = true }) {
                                Text("Change")
                            }
                        Button(
                            role: .destructive,
                            action: { image = nil }) {
                                Text("Clear")
                            }
                    }
            } else {
                Button(action: { presentingImagePicker = true }) {
                    Label(label, systemImage: "photo")
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 7.5)
                                .strokeBorder(style: .init(lineWidth: 2, dash: [4]))
                                .foregroundColor(.accentColor))
                }
            }
        }
        .imagePicker(
            isPresented: $presentingImagePicker,
            onSelect: { image = $0 })
    }
}

struct UIKitImagePickerButton_PreviewProvider : PreviewProvider {
    
    static var previews: some View {
        Wrapper()
    }
    
    private struct Wrapper : View {
        
        @State private var image: UIImage? = nil
        
        var body: some View {
            UIKitImagePickerButton(
                label: "Preview",
                image: $image)
                .frame(maxHeight: 300)
        }
    }
}
