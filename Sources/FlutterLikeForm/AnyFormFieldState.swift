/// A protocol that defines the necessary methods and properties for a form field's state.
/// Conforming types represent the state of a field in a form, allowing validation and reset of the field's state.
public protocol AnyFormFieldState {
    /// A unique identifier for the form field state.
    var id: String { get }

    /// A Boolean value indicating whether the form field is in a valid state.
    var isValid: Bool { get }

    /// Validates the form field and updates its validity state.
    func validate()

    /// Resets the form field to its initial state, clearing any error messages and validation results.
    func reset()
}
