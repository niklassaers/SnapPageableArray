@testable import SnapPageableArray

class TestElement {
    private var _id: Int
    var data: Int
    
    init(id: Int, data: Int) {
        _id = id
        self.data = data
    }
}

extension TestElement: DTOProtocol {
    var id: UInt64? {
        get {
            return UInt64(_id)
        }
    }
}