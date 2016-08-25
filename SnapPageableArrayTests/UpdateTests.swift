import XCTest
import Foundation
import SnapPageableArray

class UpdateTests: PageableArrayTests {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
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
        
        let updatedElements = [TestElement(id: index, data: index)]
        
        let updated = array.updateElements(updatedElements)
        XCTAssertEqual(0, updated.count)
    }
    
    func testResizeShouldUpdateIndexes() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        let index = 9
        array.removeElementAtIndex(UInt(3))
        
        let updatedElements = [TestElement(id: index, data: index)]
        
        let updated = array.updateElements(updatedElements)
        XCTAssertEqual(1, updated.count)
    }
    
    
    func testTopUpShouldUpdateOldElements() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        var newElements = [TestElement]()
        for i in 0..<size/2 {
            newElements.append(TestElement(id: i, data: i * 10))
        }
        array.topUpWithElements(newElements)
        
        for i in 0..<size/2 {
            let element = array[UInt(i)]
            XCTAssertNotNil(element)
            XCTAssertEqual(i * 10, element!.data)
        }
    }
    
    func testResizeToShouldResizeArray() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        array.resizeTo(UInt(size * 2))
        
        for i in 0..<size {
            array[UInt(i + size)] = TestElement(id: i + size, data: i + size)
        }
        
        for i in size..<size * 2 {
            let element = array[UInt(i)]
            XCTAssertNotNil(element)
            XCTAssertEqual(i, element!.data)
        }
    }
    
    func testFetchingReloadedElementShouldTriggerRequest() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        array.delegate = self
        
        for i in 0..<size {
            XCTAssertNotNil(array[UInt(i)])
        }

        array.markAllItemsAsNeedToReload()
        
        for i in 0..<size {
            let element = array[UInt(i)]
        }
        
        for i in 0..<size {
            XCTAssertTrue(requestedElements.contains(i))
        }
    }
}
