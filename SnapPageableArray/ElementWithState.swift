import Foundation

public final class ElementWithState<T: DTOProtocol> {
    public var element: T?
    public var state: DTOState
    
    init(element: T?, state: DTOState) {
        self.element = element
        self.state = state
    }
}
