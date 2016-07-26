import Foundation

public protocol PageableArrayDelegate : class {
    func loadContentForRange(range: Range<UInt>, pageSize: UInt)
}
