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
    
    func testUpdateElementsShouldUpdateElement() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        let ids = [2, 3]
        
        var updatedElements = [TestElement]()
        for id in ids {
            updatedElements.append(TestElement(id: id, data: id * 10))
        }
        array.updateElements(updatedElements)
        
        for id in ids {
            let element = array[UInt(id)]
            XCTAssertNotNil(element)
            XCTAssertEqual(id * 10, element!.data)
        }
    }
    
    func testUpdateElementsShouldReturnUpdatedIndexes() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        let ids = [2, 3]
        
        var updatedElements = [TestElement]()
        for id in ids {
            updatedElements.append(TestElement(id: id, data: id * 10))
        }
        let updated = array.updateElements(updatedElements)

        for id in ids {
            XCTAssertTrue(updated.contains(UInt(id)))
        }
    }
    
    func testRemovedElementShouldNotBeUpdated() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        let index = 3
        array.removeElementAtIndex(UInt(index))
        
        let updatedElements = [TestElement(id: index, data: 3)]
        
        let updated = array.updateElements(updatedElements)
        XCTAssertEqual(0, updated.count)
    }
}
