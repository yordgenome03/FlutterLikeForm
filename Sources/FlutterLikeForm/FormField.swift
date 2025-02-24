import SwiftUI

/// A SwiftUI view that represents a form field with a customizable error message and validation state.
/// It allows rendering any content, and automatically manages the error message display based on the validation state.
public struct FormField<Content: View, Value: Equatable>: View {
    /// The state of the form field, which includes its validation status and error message.
    @ObservedObject var state: FormFieldState<Value>

    /// A `FocusState` used to track whether the form field is focused or not.
    @FocusState private var isFocused: Bool

    /// The configuration for the form field, such as error message appearance.
    let config: FormFieldConfig

    /// A closure that provides the content to be displayed in the form field (e.g., `TextField`, `Text`, etc.).
    let content: () -> Content

    /// Initializes a new `FormField` view.
    /// - Parameters:
    ///   - state: The state of the form field, containing the validation status and error message.
    ///   - config: The configuration of the form field (default is an empty configuration).
    ///   - content: A closure that provides the content of the form field.
    public init(state: FormFieldState<Value>, config: FormFieldConfig = .init(), content: @escaping () -> Content) {
        self.state = state
        self.config = config
        self.content = content
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
            // TODO: Implement proper focus state management
//                .focused($isFocused)
//                .onChange(of: state.formState.previousActiveFieldId) { previousActiveFieldId in
//                    if state.formState.autovalidateMode == .onUnfocus,
//                       previousActiveFieldId == state.id
//                    {
//                        isFocused = false
//                    }
//                }

            errorText
        }
    }

    /// A private computed property that returns the error text view.
    /// If an error message exists, it will be displayed according to the configuration. Otherwise, an empty view will be shown based on the `hideEmptyErrorSpace` flag.
    private var errorText: some View {
        var message: String
        if let errorMessage = state.errorMessage {
            message = errorMessage
        } else if !config.hideEmptyErrorSpace {
            message = " "
        } else {
            return EmptyView()
        }

        return Text(message)
            .foregroundColor(config.errorMessageColor)
            .font(config.errorMessageFont)
            .padding(config.errorMessagePadding)
            .frame(maxWidth: .infinity, alignment: config.errorMessageAlignment)
    }
}
