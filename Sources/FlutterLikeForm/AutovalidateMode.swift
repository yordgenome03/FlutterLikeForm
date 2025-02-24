/// An enumeration that defines the different modes for automatic form validation.
/// The mode controls when the fields in the form should be automatically validated.
public enum AutovalidateMode: String {
    /// Validation is disabled, and fields must be manually validated.
    case disabled

    /// Fields are always validated, regardless of user interaction.
    case always

    /// Fields are validated only after user interaction, such as entering or changing a value.
    case onUserInteraction

    /// Fields are validated when they lose focus (i.e., when the user moves away from the field).
    case onUnfocus
}
