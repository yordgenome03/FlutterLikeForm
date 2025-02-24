import Combine
import Foundation

/// A state model for a form field that tracks its value, validation status, error message, and interaction state.
///
/// This class conforms to `ObservableObject` to allow automatic updates to the UI, and it supports validation logic.
public class FormFieldState<Value>: ObservableObject, Equatable, AnyFormFieldState where Value: Equatable {
    /// The global form state, which includes general form-level settings and information.
    public let formState: FormState

    /// The current value of the form field.
    @Published public var value: Value

    /// An optional error message to be displayed if the field is invalid.
    @Published public var errorMessage: String? = nil

    /// A flag indicating whether the user has interacted with the field.
    @Published public var hasInteracted = false

    /// A flag indicating whether the field is valid or not.
    @Published public var isValid = true

    /// A computed property to determine whether there is an error (i.e., whether `errorMessage` is non-nil).
    public var hasError: Bool { errorMessage != nil }

    /// A custom validator closure that can be used to validate the field's value.
    var validator: ((Value) -> String?)?

    /// A unique identifier for the form field.
    public let id: String

    /// A set of cancellables used to manage the Combine subscriptions.
    private var cancellables = Set<AnyCancellable>()

    /// Initializes a new instance of `FormFieldState`.
    ///
    /// - Parameters:
    ///   - formState: The global state of the form that this field belongs to.
    ///   - id: A unique identifier for the field.
    ///   - initialValue: The initial value of the form field.
    ///   - validator: An optional validation closure to validate the value of the field.
    public init(formState: FormState, id: String, initialValue: Value, validator: ((Value) -> String?)? = nil) {
        self.formState = formState
        self.id = id
        self.value = initialValue
        self.validator = validator

        // Add the field state to the form's list of field states.
        DispatchQueue.main.async {
            formState.addFieldState(self)
        }

        // Watch for changes to the field's value and trigger validation based on the form's autovalidate mode.
        $value
            .dropFirst()
            .sink { [weak self] _ in
                guard let self else { return }

                formState.updateActiveFieldId(id)

                switch formState.autovalidateMode {
                case .always:
                    DispatchQueue.main.async {
                        self.validate()
                    }
                case .onUserInteraction:
                    if hasInteracted {
                        DispatchQueue.main.async {
                            self.validate()
                        }
                    }
                case .disabled, .onUnfocus:
                    break
                }
                self.hasInteracted = true
            }
            .store(in: &cancellables)

        // Watch for changes to the active field ID and trigger validation if necessary.
        formState.$activeFieldId
            .dropFirst()
            .sink { [weak self] activeFieldId in
                guard let self else { return }

                if activeFieldId != id,
                   formState.previousActiveFieldId == id,
                   formState.autovalidateMode == .onUnfocus
                {
                    validate()
                }
            }
            .store(in: &cancellables)
    }

    /// Resets the form field's state, clearing the error message and interaction state.
    public func reset() {
        errorMessage = nil
        hasInteracted = false
        isValid = true
    }

    /// Validates the field's current value using the provided validator, if available.
    public func validate() {
        if let validator {
            errorMessage = validator(value)
            isValid = errorMessage == nil
        }
    }

    /// Updates the field's value and triggers validation.
    /// - Parameter value: The new value for the field.
    public func didChange(value: Value) {
        self.value = value
        hasInteracted = true
        validate()
    }

    /// Conformance to `Equatable`. Two form fields are considered equal if their `id` properties are equal.
    public static func == (lhs: FormFieldState<Value>, rhs: FormFieldState<Value>) -> Bool {
        lhs.id == rhs.id
    }
}
