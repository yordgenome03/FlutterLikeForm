import Combine
import Foundation

/// A state model that manages the global state for a form, including the validation status and active field.
/// This class tracks the active field, its previous state, and controls the validation and resetting of all form fields.
public class FormState: ObservableObject {
    /// A collection of form field states.
    private var fieldStates: [AnyFormFieldState]

    /// The mode for automatic validation of fields, determining when the fields should be validated.
    public var autovalidateMode: AutovalidateMode

    /// The ID of the previously active field.
    @Published public var previousActiveFieldId: String?

    /// The ID of the currently active field.
    @Published public var activeFieldId: String?

    /// Initializes a new instance of `FormState`.
    ///
    /// - Parameters:
    ///   - fieldStates: An array of form field states to initialize the form with. Default is an empty array.
    ///   - autovalidateMode: The mode for automatic validation of form fields. Default is `.onUnfocus`.
    public init(fieldStates: [AnyFormFieldState] = [], autovalidateMode: AutovalidateMode = .onUnfocus) {
        self.fieldStates = fieldStates
        self.autovalidateMode = autovalidateMode
    }

    /// Updates the active field ID and keeps track of the previous active field ID.
    ///
    /// - Parameter id: The ID of the field that is now active.
    public func updateActiveFieldId(_ id: String?) {
        guard id != activeFieldId else { return }

        previousActiveFieldId = activeFieldId
        activeFieldId = id
    }

    /// Adds a field state to the form.
    ///
    /// - Parameter state: The field state to be added.
    public func addFieldState(_ state: AnyFormFieldState) {
        fieldStates.append(state)
    }

    /// Removes a field state from the form.
    ///
    /// - Parameter state: The field state to be removed.
    public func removeFieldState(_ state: AnyFormFieldState) {
        fieldStates.removeAll { $0.id == state.id }
    }

    /// Validates all the fields in the form and returns a Boolean indicating if all fields are valid.
    ///
    /// - Returns: `true` if all fields are valid, `false` otherwise.
    public func validate() -> Bool {
        fieldStates.forEach { $0.validate() }
        return fieldStates.allSatisfy(\.isValid)
    }

    /// Resets the state of all fields in the form, clearing their error messages and interaction states.
    public func reset() {
        fieldStates.forEach { $0.reset() }
        activeFieldId = nil
        previousActiveFieldId = nil
    }
}
