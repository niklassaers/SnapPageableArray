import Foundation

public enum UpdateResult {
    case NoNewItems
    case SomeNewItems(newItems: Int)
    case AllNewItems
}

public func ==(lhs: UpdateResult, rhs: UpdateResult) -> Bool {
    switch (lhs, rhs) {
    case (.NoNewItems, .NoNewItems): return true
    case (.SomeNewItems(let count1), .SomeNewItems(let count2)): return count1 == count2
    case (.AllNewItems, .AllNewItems): return true
    default: return false
    }
}

extension UpdateResult: Equatable {}
