import SnapPageableArray
import XCTest

class InitTests: PageableArrayTests {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitShouldSetPagesize() {
        let capacity: UInt = 100
        let pageSize: UInt = 10
        let array = PageableArray<TestElement>(capacity: capacity, pageSize: pageSize)
        
        XCTAssertEqual(pageSize, array.pageSize)
    }
    
    func testSetPagesizeShouldSetPagesize() {
        let capacity: UInt = 100
        var pageSize: UInt = 10
        var array = PageableArray<TestElement>(capacity: capacity, pageSize: pageSize)
        pageSize = 50
        array.pageSize = pageSize
        
        XCTAssertEqual(pageSize, array.pageSize)
    }
    
    func testInitShouldSetSize() {
        let capacity: UInt = 100
        let pageSize: UInt = 10
        let array = PageableArray<TestElement>(capacity: capacity, pageSize: pageSize)
        
        XCTAssertEqual(capacity, array.count)
    }
    
    func testInitShouldSetNumberOfItemsAhead() {
        let capacity: UInt = 100
        let pageSize: UInt = 10
        let array = PageableArray<TestElement>(capacity: capacity, pageSize: pageSize)
        
        XCTAssertNotEqual(0, array.numberOfItemsAheadOfLastToTriggerLoadMore)
    }
    
    func testSetNumberOfItemsAheadShouldSetNumberOfItemsAhead() {
        let capacity: UInt = 100
        let pageSize: UInt = 10
        var array = PageableArray<TestElement>(capacity: capacity, pageSize: pageSize)
        
        let numberOfItemsAhead: UInt = 10
        array.numberOfItemsAheadOfLastToTriggerLoadMore = numberOfItemsAhead
        
        XCTAssertEqual(numberOfItemsAhead, array.numberOfItemsAheadOfLastToTriggerLoadMore)
    }
}
