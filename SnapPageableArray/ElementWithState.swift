import Foundation

public struct ElementWithState<T: DTOProtocol> {
    var element: T?
    var state: DTOState
}
