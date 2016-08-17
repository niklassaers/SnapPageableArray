import Foundation

public protocol PageableArrayProtocol {
    associatedtype Element

    init(capacity: UInt, pageSize: UInt)

    var pageSize: UInt { get set }
    var count: UInt { get }
    var numberOfItemsAheadOfLastToTriggerLoadMore: UInt { get set }
    weak var delegate: PageableArrayDelegate? { get set }

    mutating func topUpWithElements(elements: [Element]) -> UpdateResult
    mutating func appendElement(element: Element)
    mutating func updatePage(page: Pageable, withElements: [Element], offset: UInt)
    mutating func resizeTo(newSize: UInt)
    mutating func markAllItemsAsNeedToReload()
    mutating func removeElementAtIndex(index: UInt)
    mutating func updateElements(elements: [Element]) -> [UInt]

    subscript(index: UInt) -> Element? { mutating get }
    func hasElementAtIndex(index: UInt) -> Bool

    func persist() -> [UInt64?]


    mutating func removeElementsMatching(matcher: Element -> (Bool)) -> UInt
}
