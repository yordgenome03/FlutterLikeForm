import SwiftUI

public struct FormFieldConfig {
    public init() {}
}

public struct FormField<Content: View, Value: Equatable>: View {
    @ObservedObject var state: FormFieldState<Value>
    @FocusState private var isFocused: Bool
    let config: FormFieldConfig

    let content: () -> Content

    public init(state: FormFieldState<Value>, config: FormFieldConfig = .init(), content: @escaping () -> Content) {
        self.state = state
        self.config = config
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            content()
                .focused($isFocused)
                .onChange(of: state.formState.previousActiveFieldId) { previousActiveFieldId in
                    if state.formState.autovalidateMode == .onUnfocus,
                       previousActiveFieldId == state.id
                    {
                        isFocused = false
                    }
                }

            VStack {
                if let errorMessage = state.errorMessage {
                    HStack {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 12))
                    }
                } else {
                    Spacer()
                }
            }
            .frame(height: 20)
        }
        .id(state.id)
    }
}
