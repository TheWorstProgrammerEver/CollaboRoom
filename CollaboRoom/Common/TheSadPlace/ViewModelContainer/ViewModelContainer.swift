
// NOTE: RH - ViewModels are ObservableObjects.
// They are instantiated via the @StateObject property wrapper.
// Unfortunately @StateObjects can only be initialized inline.
// If they take dependencies (i.e. init params)

import SwiftUI

// NOTE: RH - This causes toolbar items to "pop" in (i.e. suddenly appear) after the transition.
// Seems like a new bug with SwiftUI as I've never noticed it before.
// I'll ensure this compromise for the sake of being able to have DI on my ViewModels...

class ModelContainer<T> : ObservableObject {
    
    @Published private(set) var model: T? = nil
    
    func load(_ t: T) {
        if model != nil { return }
        
        model = t
    }
}

struct ViewContainer<Model, Content> : View where Content : View {
    
    @StateObject var modelContainer: ModelContainer<Model> = .init()
    
    private let modelInitializer: () -> Model
    private let content: (Model) -> Content
    
    init(
        _ modelInitializer: @autoclosure @escaping () -> Model,
        @ViewBuilder _ content: @escaping (Model) -> Content) {
            self.content = content
            self.modelInitializer = modelInitializer
        }
    
    @ViewBuilder var body: some View {
        switch modelContainer.model {
        
        case .some(let model):
            content(model)
        
        default:
            Color.clear
                .onAppear {
                    modelContainer.load(modelInitializer())
                }
        }
    }
}
