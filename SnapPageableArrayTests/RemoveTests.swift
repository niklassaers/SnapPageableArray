import SnapPageableArray
import XCTest

class RemoveTests: PageableArrayTests {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testRemoveElementAtIndexShouldRemoveElement() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        let index = 5
        array.removeElementAtIndex(5)
        
        let element = array[UInt(index)]
        XCTAssertNotNil(element)
        XCTAssertEqual(index + 1, element!.data)
    }
    
    func testRemoveElementAtIndexShouldDecreaseCount() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        array.removeElementAtIndex(5)
        
        XCTAssertEqual(UInt(size - 1), array.count)
    }
}
