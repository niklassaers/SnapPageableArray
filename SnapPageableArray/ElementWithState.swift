import Foundation

final class ElementWithState<T: DTOProtocol> {
    var state: DTOState
    
    var element: T? {
        didSet {
            id = element?.id
        }
    }
    
    var id: UInt64?
    
    init(element: T?, state: DTOState) {
        self.element = element
        self.state = state
    }
}
