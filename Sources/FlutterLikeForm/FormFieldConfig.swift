import SwiftUI

/// A configuration struct that defines the appearance and behavior of the error message in the `FormField`.
/// You can customize the error message's color, font, padding, alignment, and visibility.
public struct FormFieldConfig {
    /// The color of the error message text.
    public var errorMessageColor: Color

    /// The font style of the error message text.
    public var errorMessageFont: Font

    /// The padding around the error message text.
    public var errorMessagePadding: EdgeInsets

    /// The alignment of the error message text.
    public var errorMessageAlignment: Alignment

    /// A flag to determine whether the space for the error message should be hidden when the message is empty.
    public var hideEmptyErrorSpace: Bool

    /// Initializes a new `FormFieldConfig` with customizable options.
    /// - Parameters:
    ///   - errorMessageColor: The color of the error message text (default is `.red`).
    ///   - errorMessageFont: The font style of the error message text (default is `.system(size: 12)`).
    ///   - errorMessagePadding: The padding around the error message (default is `.init(top: 4, leading: 0, bottom: 0, trailing: 0)`).
    ///   - errorMessageAlignment: The alignment of the error message text (default is `.leading`).
    ///   - hideEmptyErrorSpace: A flag to hide the error space when the message is empty (default is `false`).
    public init(
        errorMessageColor: Color = .red,
        errorMessageFont: Font = .system(size: 12),
        errorMessagePadding: EdgeInsets = .init(top: 4, leading: 0, bottom: 0, trailing: 0),
        errorMessageAlignment: Alignment = .leading,
        hideEmptyErrorSpace: Bool = false
    ) {
        self.errorMessageColor = errorMessageColor
        self.errorMessageFont = errorMessageFont
        self.errorMessagePadding = errorMessagePadding
        self.errorMessageAlignment = errorMessageAlignment
        self.hideEmptyErrorSpace = hideEmptyErrorSpace
    }
}
