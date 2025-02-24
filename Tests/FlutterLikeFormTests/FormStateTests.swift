@testable import FlutterLikeForm
import XCTest

final class FormStateTests: XCTestCase {
    func testFormStateInitialization() {
        let formState = FormState()

        XCTAssertNil(formState.activeFieldId)
        XCTAssertNil(formState.previousActiveFieldId)
        XCTAssertTrue(formState.validate())
    }

    func testAddFieldState() {
        let formState = FormState()
        let fieldState = FormFieldState(formState: formState, id: "name", initialValue: "") { name in
            name.isEmpty ? "Required" : nil
        }

        formState.addFieldState(fieldState)
        fieldState.validate()

        XCTAssertEqual(formState.validate(), fieldState.isValid)
        XCTAssertFalse(formState.validate())

        fieldState.value = "John"

        XCTAssertEqual(formState.validate(), fieldState.isValid)
        XCTAssertTrue(formState.validate())
    }

    func testUpdateActiveFieldId() {
        let formState = FormState()
        let nameFieldState = FormFieldState(formState: formState, id: "name", initialValue: "")
        let emailFieldState = FormFieldState(formState: formState, id: "email", initialValue: "")
        formState.addFieldState(nameFieldState)
        formState.addFieldState(emailFieldState)

        XCTAssertNil(formState.activeFieldId)
        XCTAssertNil(formState.previousActiveFieldId)

        formState.updateActiveFieldId("name")

        XCTAssertEqual(formState.activeFieldId, "name")
        XCTAssertNil(formState.previousActiveFieldId)

        formState.updateActiveFieldId("email")

        XCTAssertEqual(formState.activeFieldId, "email")
        XCTAssertEqual(formState.previousActiveFieldId, "name")
    }

    func testNoChangeInActiveFieldId() {
        let formState = FormState()
        let nameFieldState = FormFieldState(formState: formState, id: "name", initialValue: "")
        formState.addFieldState(nameFieldState)

        formState.updateActiveFieldId("name") // No change

        XCTAssertEqual(formState.activeFieldId, "name")
        XCTAssertNil(formState.previousActiveFieldId)
    }

    func testResetForm() {
        let formState = FormState()
        let nameFieldState = FormFieldState(formState: formState, id: "name", initialValue: "name") { name in
            name.isEmpty ? "Required" : nil
        }

        formState.addFieldState(nameFieldState)
        XCTAssertTrue(formState.validate())

        XCTAssertTrue(nameFieldState.isValid)
        XCTAssertNil(nameFieldState.errorMessage)

        nameFieldState.value = ""
        XCTAssertFalse(formState.validate())

        XCTAssertFalse(nameFieldState.isValid)
        XCTAssertNotNil(nameFieldState.errorMessage)

        XCTAssertEqual(formState.activeFieldId, nameFieldState.id)

        formState.reset()

        XCTAssertTrue(nameFieldState.isValid)
        XCTAssertNil(nameFieldState.errorMessage)
        XCTAssertFalse(formState.validate())
        XCTAssertNil(formState.activeFieldId)
    }
}
