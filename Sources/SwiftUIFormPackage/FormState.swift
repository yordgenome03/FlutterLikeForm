import Combine
import Foundation

public class FormState: ObservableObject {
    private var fieldStates: [AnyFormFieldState]
    public var autovalidateMode: AutovalidateMode
    @Published public var previousActiveFieldId: String?
    @Published public var activeFieldId: String?
    @Published public var isValidAll = false
    
    public init(fieldStates: [AnyFormFieldState] = [], autovalidateMode: AutovalidateMode = .onUnfocus) {
        self.fieldStates = fieldStates
        self.autovalidateMode = autovalidateMode
    }
    
    public func updateActiveFieldId(_ id: String?) {
        guard id != activeFieldId else { return }
        
        self.previousActiveFieldId = self.activeFieldId
        self.activeFieldId = id
    }
    
    public func addFieldState(_ state: AnyFormFieldState) {
        fieldStates.append(state)
    }
    
    public func removeFieldState(_ state: AnyFormFieldState) {
        fieldStates.removeAll { $0.id == state.id }
    }
    
    public func validate() {
        fieldStates.forEach { $0.validate() }
        isValidAll = fieldStates.allSatisfy { $0.isValid }
    }
    
    public func reset() {
        fieldStates.forEach { $0.reset() }
        activeFieldId = nil
        previousActiveFieldId = nil
        isValidAll = false
    }
}
