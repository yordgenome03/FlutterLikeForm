import Combine
import Foundation

public class FormState: ObservableObject {
    private var fieldStates: [AnyFormFieldState]
    public var autovalidateMode: AutovalidateMode
    @Published public var previousActiveFieldId: String?
    @Published public var activeFieldId: String?

    public init(fieldStates: [AnyFormFieldState] = [], autovalidateMode: AutovalidateMode = .onUnfocus) {
        self.fieldStates = fieldStates
        self.autovalidateMode = autovalidateMode
    }

    public func updateActiveFieldId(_ id: String?) {
        guard id != activeFieldId else { return }

        previousActiveFieldId = activeFieldId
        activeFieldId = id
    }

    public func addFieldState(_ state: AnyFormFieldState) {
        fieldStates.append(state)
    }

    public func removeFieldState(_ state: AnyFormFieldState) {
        fieldStates.removeAll { $0.id == state.id }
    }

    public func validate() -> Bool {
        fieldStates.forEach { $0.validate() }
        return fieldStates.allSatisfy(\.isValid)
    }

    public func reset() {
        fieldStates.forEach { $0.reset() }
        activeFieldId = nil
        previousActiveFieldId = nil
    }
}
