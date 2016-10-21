import Foundation

/*extension String: CustomStringConvertible {
    public var description: String { return self }
}*/

public extension Dictionary where
    Key : CustomStringConvertible,
    Value : AnyObject {

    mutating func set(_ key: Key, _ value: Value?) {
        if let value = value {
            self[key] = value
        }
    }

    mutating func set(_ key: Key, _ value: UInt64?) {
        if let value = value {
            let v =  NSNumber(value: value as UInt64) as! Value
            self[key] = v
        }
    }
}

//extension Optional where Wrapped : Dictionary,
//Key : String,
//Value : AnyObject {

//extension Optional where Wrapped : Dictionary<String, AnyObject> {
/*public extension Dictionary where
    Key : CustomStringConvertible,
    Value : AnyObject {

    public func asAnyDictionary() -> [String:Any] {
        let nsdict = (self as! [String:AnyObject]) as NSDictionary
        return nsdict.asSwiftAnyDictionary()
    }
}*/

public extension NSDictionary {

    public func asSwiftAnyDictionary() -> [String:Any] {
        let dict = self as! [String:AnyObject]
        var ret = [String:Any]()

        for (key, value) in dict {
            let value = value as Any
            ret[key] = value
        }

        return ret
    }

}

public extension Dictionary where
    Key : ExpressibleByStringLiteral,
    Value : Any {



    public func asNSDictionary() -> NSDictionary? {

        var newDict = [String : AnyObject]()

        for (aKey, value) in self {
            guard let key = aKey as? String else {
                print("Error: Key \(aKey) must be string")
                continue
            }
            if let value = value as? AnyObject {
                if let value = value as? NSObject {
                    newDict[key] = value
                }
            } else if let value = value as? Double {
                newDict[key] = Double(value) as NSNumber
            } else if let value = value as? String {
                newDict[key] = String(value) as NSString
            } else if let value = value as? Bool {
                newDict[key] = Bool(value) as NSNumber
            } else if let value = value as? UInt64 {
                newDict[key] = NSNumber(value: value as UInt64) //  Int(value)
            } else if let value = value as? UInt {
                newDict[key] = UInt(value) as NSNumber
            } else if let value = value as? Int {
                newDict[key] = Int(value) as NSNumber
            } else if let value = value as? CGFloat {
                newDict[key] = CGFloat(value) as NSNumber
            } else if let value = value as? [String:AnyObject] {

                print("How should I treat AnyObject \(value) ??")
            } else if let value = value as? [String:Any] {

                let d = handleDictValue(value)
                if d.count > 0 {
                    let d = d as NSDictionary
                    newDict[key] = d
                } else {
                    //print("Best to check this out, nothing went into this dictionary")
                }

            } else if let value = value as? [[String:Any]] {
                newDict[key] = value.flatMap { $0.asNSDictionary() } as AnyObject
            } else if "\(value)" == "nil" { // Is there a better way to test Value for nil?
                // Skip nil values, they don't belong in an NSDictionary
            } else if let value = value as? Data {
                newDict[key] = value as AnyObject?
            } else {
                print("Error converting <\(key): \(value)> to NSDictionary")
            }
        }

        return newDict as NSDictionary
    }

    fileprivate func handleDictValue(_ value: [String:Any]) -> [String:NSObject] {
        var value = value

        let crashingDicts = ["device"]
        let allowedDicts = ["sale", "price", "time", "location", "imageTags", "image", "boost", "tags"]

        var d = [String:NSObject]()
        for key in value.keys {

            if let v = value[key] as? NSObject {
                d[key] = v
            } else if value[key] == nil {

            } else if let v = value[key] as? [String:Any] , !crashingDicts.contains(key) {

                d[key] = v.asNSDictionary()

            } else if let v = value[key] as? [String:Any] , allowedDicts.contains(key) {

                d[key] = v.asNSDictionary()

            } else if let v = value[key] as? [[String:Any]] , !crashingDicts.contains(key) {

                let ar = NSMutableArray(capacity: v.count)
                for i in 0..<v.count {
                    if let dict = v[i].asNSDictionary() {
                        ar[i] = dict
                    } else {
                        print("What?")
                    }
                }
                d[key] = ar

            } else if let v = value[key] as? [[String:Any]] , allowedDicts.contains(key) {

                let ar = NSMutableArray(capacity: v.count)
                for i in 0..<v.count {
                    if let dict = v[i].asNSDictionary() {
                        ar[i] = dict
                    } else {
                        print("What?")
                    }
                }
                d[key] = ar

            } else if let v_ = value[key] as? UInt64?,
                let v = v_ {

                d[key] = NSNumber(value: v as UInt64)

            } else {
                let tokensThatAreOKToGetHere = ["pushToken", "code", "symbol"]

                if !tokensThatAreOKToGetHere.contains(key) && !crashingDicts.contains(key) { // crashingDicts are special kinds of crashers that should be looked into at some point. Right now, I'm out of ammo
                    print("I need help with \(key)")
                }
            }
        }

        return d
    }
}
