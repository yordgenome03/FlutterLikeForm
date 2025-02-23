public protocol AnyFormFieldState {
    var id: String { get }
    var isValid: Bool { get }
    func validate()
    func reset()
}
