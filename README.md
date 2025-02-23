# SwiftUIFormPackage

A Swift package for creating forms in SwiftUI with automatic validation, similar to Flutter's Form widget. This package provides a reusable form structure with features like field validation, auto-validation modes, and form state management.

## Features

- FormState management: Tracks the state of all form fields.
- FormField: Customizable form field component that supports various input types.
- Validation: Built-in support for field validation with custom error messages.
- Auto-validation modes: Supports different auto-validation behaviors like always, on user interaction, and on unfocus.
- Reset functionality: Easily reset the form's state and field values.

## Installation

To add the SwiftUIFlutterLikeForm to your project, include it in your Package.swift file:

```swift
dependencies: [
    .package(url: "https://github.com/yordgenome03/SwiftUIFlutterLikeForm.git", from: "1.0.0")
]
```

## Usage

Here is an example of how to use the package to create a form with custom validation:

```swift
import SwiftUI
import SwiftUIFormPackage

struct MyFormView: View {
    @ObservedObject var formState: FormState
    @ObservedObject var nameFieldState: FormFieldState<String>
    @ObservedObject var emailFieldState: FormFieldState<String>

    init() {
        let formState = FormState()
        nameFieldState = FormFieldState(formState: formState, id: "name", initialValue: "", validator: { value in
            return value.isEmpty ? "Name is required" : nil
        })
        emailFieldState = FormFieldState(formState: formState, id: "email", initialValue: "", validator: { value in
            return value.isEmpty ? "Email is required" : nil
        })

        self.formState = formState
    }

    var body: some View {
        VStack {
            FormField(state: nameFieldState) {
                TextField("Name", text: $nameFieldState.value)
            }

            FormField(state: emailFieldState) {
                TextField("Email", text: $emailFieldState.value)
            }

            Button("Submit") {
                if formState.validate() {
                    print("All fields are valid.")
                }
            }
        }
        .padding()
    }
}
```

## Auto-Validation Modes

The form supports different auto-validation modes:

- .always: Automatically validates the field when the value changes.
- .onUserInteraction: Validates after the user interacts with the field.
- .onUnfocus: Validates when the field loses focus.
- .disabled: Validation is disabled.

You can set the auto-validation mode globally for the form using the FormState:

```swift
formState.autovalidateMode = .onUserInteraction
```

## Testing

To ensure the form and field validation logic works correctly, we've included a suite of unit tests. Run the tests using Xcode's test runner to validate the functionality of the form components.

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

## Changelog

All notable changes to this project will be documented in the [CHANGELOG](CHANGELOG.md) file.

See the full changelog [here](CHANGELOG.md).

## License

This package is licensed under the MIT License. See [LICENSE](LICENSE) for more information.
