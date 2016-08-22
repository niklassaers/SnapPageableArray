import XCTest
import SnapPageableArray

class PageableArrayTests: XCTestCase {
    func createArrayWithSize(size: Int, pageSize: Int) -> PageableArray<TestElement> {
        var array = PageableArray<TestElement>(capacity: UInt(size), pageSize: UInt(pageSize))
        for i in 0..<size {
            array[UInt(i)] = TestElement(id: i, data: i)
        }
        
        return array
    }
}
