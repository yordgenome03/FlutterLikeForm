# CHANGELOG

## [1.0.1] - 2025-02-25

### Fixed

- Resolved issue where the `errorText` computed property in `FormField` had mismatched underlying return types, causing compilation errors. `EmptyView` and `Text` are now wrapped in `AnyView` to ensure consistency in the return type.

## [1.0.0] - 2025-02-25

### Added

- `FormFieldConfig`: A configuration struct for customizing form field appearances and behaviors (e.g., error message color, padding, font).
- `FormField`: A customizable SwiftUI form field component, which supports validation, error handling, and state management.

### Changed

- Updated initialization of `FormFieldConfig` with default values to improve flexibility for customization.

## [0.1.0] - 2025-02-24

### Initial development

- Set up the SwiftUIFlutterLikeForm repository.
- Defined basic structure and models for handling form state and validation logic.
