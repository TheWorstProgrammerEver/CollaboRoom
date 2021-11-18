
import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    var onSelect: (UIImage) -> Void
    
    @Environment(\.presentationMode) private var presentation

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {

        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator

        return imagePicker
    }

    func updateUIViewController(
        _ uiViewController: UIImagePickerController,
        context: UIViewControllerRepresentableContext<ImagePicker>) { }

    func makeCoordinator() -> Coordinator { .init(self) }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        private let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

                if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    parent.onSelect(image)
                }
                
                parent.presentation.wrappedValue.dismiss()
            }
    }
}
