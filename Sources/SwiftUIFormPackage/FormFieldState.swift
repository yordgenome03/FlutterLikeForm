import Combine
import Foundation

public class FormFieldState<Value>: ObservableObject, Equatable, AnyFormFieldState where Value: Equatable {
    public let formState: FormState
    @Published public var value: Value
    @Published public var errorMessage: String? = nil
    @Published public var hasInteracted = false
    @Published public var isValid = true
    public var hasError: Bool { errorMessage != nil }
    
    var validator: ((Value) -> String?)?
    public let id: String
    
    private var cancellables = Set<AnyCancellable>()
    
    public init(formState: FormState, id: String, initialValue: Value, validator: ((Value) -> String?)? = nil) {
        self.formState = formState
        self.id = id
        self.value = initialValue
        self.validator = validator
        
        DispatchQueue.main.async {
            formState.addFieldState(self)
        }
        
        $value
            .dropFirst()
            .sink { [weak self] newValue in
                guard let self = self else { return }
                
                formState.updateActiveFieldId(id)
                
                switch formState.autovalidateMode {
                case .always:
                    DispatchQueue.main.async {
                        self.validate()
                    }
                case .onUserInteraction: 
                    if self.hasInteracted {
                        DispatchQueue.main.async {
                            self.validate()
                        }
                    }
                case .disabled, .onUnfocus:
                    break
                }
                self.hasInteracted = true
            }
            .store(in: &cancellables)
        
        formState.$activeFieldId
            .dropFirst()
            .sink { [weak self] activeFieldId in
                guard let self = self else { return }
                
                if activeFieldId != id,
                   formState.previousActiveFieldId == id,
                   formState.autovalidateMode == .onUnfocus {
                    validate()
                }
            }
            .store(in: &cancellables)
        
    }
    
    public func reset() {
        errorMessage = nil
        hasInteracted = false
        isValid = true   
    }
    
    public func validate() {
        if let validator {          
            errorMessage = validator(value)
            isValid = errorMessage == nil
        }
    }
    
    public func didChange(value: Value) {
        self.value = value
        self.hasInteracted = true
        validate()
    }
    
    public static func ==(lhs: FormFieldState<Value>, rhs: FormFieldState<Value>) -> Bool {
        return lhs.id == rhs.id
    }
}
