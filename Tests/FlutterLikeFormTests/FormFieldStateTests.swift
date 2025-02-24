@testable import FlutterLikeForm
import XCTest

final class FormFieldStateTests: XCTestCase {
    func testInitialState() {
        let formState = FormState()
        let fieldState = FormFieldState(formState: formState, id: "name", initialValue: "John Doe")

        XCTAssertEqual(fieldState.value, "John Doe")
        XCTAssertNil(fieldState.errorMessage)
        XCTAssertFalse(fieldState.hasInteracted)
        XCTAssertTrue(fieldState.isValid)
    }

    func testValueChangeUpdatesHasInteracted() {
        let formState = FormState()
        let fieldState = FormFieldState(formState: formState, id: "email", initialValue: "")

        fieldState.value = "test@example.com"

        XCTAssertTrue(fieldState.hasInteracted)
    }

    func testValidation() {
        let formState = FormState()
        let fieldState = FormFieldState(formState: formState, id: "password", initialValue: "", validator: { value in
            value.count < 8 ? "Too short" : nil
        })

        fieldState.value = "12345"
        fieldState.validate()

        XCTAssertEqual(fieldState.errorMessage, "Too short")
        XCTAssertFalse(fieldState.isValid)

        fieldState.value = "password123"
        fieldState.validate()

        XCTAssertNil(fieldState.errorMessage)
        XCTAssertTrue(fieldState.isValid)
    }

    func testReset() {
        let formState = FormState()
        let fieldState = FormFieldState(formState: formState, id: "name", initialValue: "John")
        fieldState.value = "Doe"
        fieldState.hasInteracted = true
        fieldState.validate()

        fieldState.reset()

        XCTAssertNil(fieldState.errorMessage)
        XCTAssertFalse(fieldState.hasInteracted)
        XCTAssertTrue(fieldState.isValid)
    }
}
