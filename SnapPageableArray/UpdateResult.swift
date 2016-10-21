import Foundation

public enum UpdateResult {
    case noNewItems
    case someNewItems(newItems: Int)
    case allNewItems
}

public func ==(lhs: UpdateResult, rhs: UpdateResult) -> Bool {
    switch (lhs, rhs) {
    case (.noNewItems, .noNewItems): return true
    case (.someNewItems(let count1), .someNewItems(let count2)): return count1 == count2
    case (.allNewItems, .allNewItems): return true
    default: return false
    }
}

extension UpdateResult: Equatable {}
