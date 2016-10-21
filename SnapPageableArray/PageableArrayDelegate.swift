import Foundation

public protocol PageableArrayDelegate : class {
    func loadContentForRange(_ range: CountableRange<UInt>, pageSize: UInt)
}
