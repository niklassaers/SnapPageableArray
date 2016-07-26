import Foundation

public enum DictConvertibleError: ErrorType {
    case InvalidDict
    case InvalidNSData
    case RequiredValueMissing
    case InvalidType
}

public protocol DictConvertible: DataRepresentable {

    init(dict: [String:Any]) throws
    func toDict() -> [String:Any]

}

public extension DictConvertible {

    public func asData() -> NSData! {
        let dict = self.toDict()
        if let nsDict = dict.asNSDictionary() {
            return NSKeyedArchiver.archivedDataWithRootObject(nsDict)
        } else {
            return NSData()
        }
    }

    public var hash: Int {
        get {
            if let nsDict = toDict().asNSDictionary() {
                return nsDict.hash
            } else {
                return 0
            }
        }
    }
}

public protocol Verifiable {

    func isValid() -> Bool
}

private func validString(s: String?) throws -> String {
    if let s = s {
        return s
    }
    throw DictConvertibleError.RequiredValueMissing
}

public protocol DataRepresentable {
    
    func asData() -> NSData!
}