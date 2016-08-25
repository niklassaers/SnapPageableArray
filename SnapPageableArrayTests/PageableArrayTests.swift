import XCTest
import SnapPageableArray

class PageableArrayTests: XCTestCase {
    var requestedElements = Set<Int>()
    
    func createArrayWithSize(size: Int, pageSize: Int) -> PageableArray<TestElement> {
        var array = PageableArray<TestElement>(capacity: UInt(size), pageSize: UInt(pageSize))
        for i in 0..<size {
            array[UInt(i)] = TestElement(id: i, data: i)
        }
        
        return array
    }
}

extension PageableArrayTests: PageableArrayDelegate {
    func loadContentForRange(range: Range<UInt>, pageSize: UInt) {
        for i in range {
            requestedElements.insert(Int(i))
        }
    }
}