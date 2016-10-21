import Foundation

public protocol PageableArrayProtocol {
    associatedtype Element

    init(capacity: UInt, pageSize: UInt)

    var pageSize: UInt { get set }
    var count: UInt { get }
    var numberOfItemsAheadOfLastToTriggerLoadMore: UInt { get set }
    weak var delegate: PageableArrayDelegate? { get set }

    mutating func topUpWithElements(_ elements: [Element]) -> UpdateResult
    mutating func appendElement(_ element: Element)
    mutating func updatePage(_ page: Pageable, withElements: [Element], offset: UInt)
    mutating func resizeTo(_ newSize: UInt)
    mutating func markAllItemsAsNeedToReload()
    mutating func removeElementAtIndex(_ index: UInt)
    mutating func updateElements(_ elements: [Element]) -> [UInt]

    subscript(index: UInt) -> Element? { mutating get }
    func hasElementAtIndex(_ index: UInt) -> Bool

    func persist() -> [UInt64?]


    mutating func removeElementsMatching(_ matcher: (Element) -> (Bool)) -> UInt
}
