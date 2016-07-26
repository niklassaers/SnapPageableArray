import Foundation

public enum UpdateResult {
    case NoNewItems
    case SomeNewItems(newItems: Int)
    case AllNewItems
}
