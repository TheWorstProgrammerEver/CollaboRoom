
// NOTE: RH - On iPhones you can't dismiss the keyboard natively.
// I really don't know why. I just don't. I like, I never understood this.

import SwiftUI

struct DismissibleKeyboardWorkaround : ViewModifier {
    
    @FocusState private var focused: Bool
    
    func body(content: Content) -> some View {
        content
            .focused($focused)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button(action: { focused = false }) {
                        Text("Done")
                    }
                }
            }
    }
}

extension View {
    func dismissibleKeyboardWorkaround() -> some View {
        modifier(DismissibleKeyboardWorkaround())
    }
}
