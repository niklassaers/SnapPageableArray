import Foundation

public enum DictConvertibleError: Error {
    case invalidDict
    case invalidNSData
    case requiredValueMissing
    case invalidType
}

public protocol DictConvertible: DataRepresentable {

    init(dict: [String:Any]) throws
    func toDict() -> [String:Any]

}

public extension DictConvertible {

    public func asData() -> Data! {
        let dict = self.toDict()
        if let nsDict = dict.asNSDictionary() {
            return NSKeyedArchiver.archivedData(withRootObject: nsDict)
        } else {
            return Data()
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

private func validString(_ s: String?) throws -> String {
    if let s = s {
        return s
    }
    throw DictConvertibleError.requiredValueMissing
}

public protocol DataRepresentable {

    func asData() -> Data!
}
