
// NOTE: RH - Current SwiftUI TextEditor doesn't support... much.
// Including placeholder...
// Sooooo this is ... how we do. =(
// Not sure when they'll ever add support for this oft-used and oft-requested feature.

import SwiftUI

struct BetterTextEditor : View {
    
    var label: String
    @Binding var text: String
    var placeholder: String? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .frame(maxWidth: .infinity, minHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 7.5))
                #if !os(macOS)
                .dismissibleKeyboardWorkaround()
                #endif
            
            if text.isEmpty, let placeholder = placeholder {
                Text(placeholder)
                    .foregroundColor(.secondary)
                    #if os(macOS)
                    .padding(.leading, 5)
                    #else
                    .padding(.top, 8.1)
                    .padding(.leading, 4.1)
                    #endif
                    .allowsHitTesting(false)
            }
        }
    }
}

