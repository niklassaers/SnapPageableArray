import XCTest
import Foundation
import SnapPageableArray

class SnapPageableArrayTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    private func createArrayWithSize(size: Int, pageSize: Int) -> PageableArray<TestElement> {
        var array = PageableArray<TestElement>(capacity: UInt(size), pageSize: UInt(pageSize))
        for i in 0..<size {
            array[UInt(i)] = TestElement(id: i, data: i)
        }
        
        return array
    }

    func testInsertElements() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        for i in 0..<size {
            let element = array[UInt(i)]
            XCTAssertNotNil(element)
            XCTAssertEqual(i, element!.data)
        }
    }
    
    func testUpdateElements() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        let id = 3
        let data = 30
        let updatedElements = [TestElement(id: id, data: data)]
        array.updateElements(updatedElements)
        
        for i in 0..<size {
            let element = array[UInt(i)]
            if let element = element where element.id == UInt64(id) {
                XCTAssertEqual(data, element.data)
            }
        }
    }
}
