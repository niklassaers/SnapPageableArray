import UIKit
import SnapPageableArray

struct LocalData {
    
    let id: UInt64?
    let color: UIColor
    
    
}

extension LocalData: DTOProtocol {
    
    var cacheId: String? {
        get {
            let theId = self.id ?? 0
            return "cacheId-\(theId)"
        }
    }
}