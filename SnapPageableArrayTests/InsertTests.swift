import XCTest
import SnapPageableArray

class InsertTests: PageableArrayTests {
    func testInsertElementsWithSubscript() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        for i in 0..<size {
            let element = array[UInt(i)]
            XCTAssertNotNil(element)
            XCTAssertEqual(i, element!.data)
        }
    }
    
    func testAppendElementShouldIncreaseCount() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        array.appendElement(TestElement(id: 11, data: 11))
        
        XCTAssertEqual(UInt(size + 1), array.count)
    }
    
    func testAppendElementShouldAppendElelemt() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        let data = 100
        
        array.appendElement(TestElement(id: data, data: data))
        
        let element = array[UInt(array.count - 1)]
        XCTAssertNotNil(element)
        XCTAssertEqual(data, element!.data)
    }
    
    func testTopUpShouldInsertNewElementsFirst() {
        let size = 10
        let pageSize = 5
        var array = createArrayWithSize(size, pageSize: pageSize)
        
        var newElements = [TestElement]()
        for i in size..<size * 2 {
            newElements.append(TestElement(id: i, data: i))
        }
        array.topUpWithElements(newElements)
        
        for i in 0..<size {
            let element = array[UInt(i)]
            XCTAssertNotNil(element)
            XCTAssertEqual(i + size, element!.data)
        }
    }
    
    func testTopUpWithNoNewItemsShouldReturnNoNewItems() {
        let size = 10
        let pageSize = 5

        var array = PageableArray<TestElement>(capacity: UInt(size), pageSize: UInt(pageSize))
        
        var elements = [TestElement]()
        for i in 0..<size {
            let element = TestElement(id: i, data: i)
            array[UInt(i)] = element
            elements.append(element)
        }
        
        let result = array.topUpWithElements(elements)
        XCTAssertEqual(result, UpdateResult.noNewItems)
    }
    
    func testTopUpWithSomeNewItemsShouldReturnSomeNewItems() {
        let size = 10
        let pageSize = 5
        
        var array = PageableArray<TestElement>(capacity: UInt(size), pageSize: UInt(pageSize))
        
        var elements = [TestElement]()
        for i in 0..<size {
            var element = TestElement(id: i, data: i)
            array[UInt(i)] = element
            if i < size/2 {
                element = TestElement(id: i + 10, data: i + 10)
            }
            elements.append(element)
        }
        
        let result = array.topUpWithElements(elements)
        XCTAssertEqual(result, UpdateResult.someNewItems(newItems: size/2))
    }
    
    func testTopUpWithAllNewItemsShouldReturnAllNewItems() {
        let size = 10
        let pageSize = 5
        
        var array = PageableArray<TestElement>(capacity: UInt(size), pageSize: UInt(pageSize))
        
        var elements = [TestElement]()
        for i in 0..<size {
            var element = TestElement(id: i, data: i)
            array[UInt(i)] = element
            
            element = TestElement(id: i + 10, data: i + 10)
            elements.append(element)
        }
        
        let result = array.topUpWithElements(elements)
        XCTAssertEqual(result, UpdateResult.allNewItems)
    }
}
