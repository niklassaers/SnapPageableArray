import Foundation
import CoreLocation

internal func genId() -> UInt64 {
    return UInt64.random()
}

internal func genBool() -> Bool {
    return UInt.random() % 2 == 0
}

internal func genOptBool() -> Bool? {
    let v = UInt.random() % 3
    if v == 0 {
        return nil
    } else if v == 1 {
        return true
    } else {
        return false
    }
}

internal func genOptInt() -> Int? {
    let v = abs(Int.random())
    if v % 5 == 0 {
        return nil
    } else {
        return Int(v)
    }
}

internal func genOptImageUrl() -> URL? {
    let v = UInt.random()
    if v % 5 == 0 {
        return nil
    } else {
        switch(v) {
        case 0:  return URL(string: "https://www.freebsd.org/gifs/daemon-phk.png")
        case 1:  return URL(string: "https://www.freebsd.org/gifs/daemon_hammer.jpg")
        case 2:  return URL(string: "https://www.freebsd.org/gifs/power.jpg")
        case 3:  return URL(string: "https://www.freebsd.org/gifs/releases.jpg")
        default: return URL(string: "https://www.freebsd.org/gifs/doc.jpg")
        }
    }
}

internal func genOptCoordinate() -> CLLocationCoordinate2D? {
    let v = UInt.random()
    if v % 5 == 0 {
        return nil
    }
    let w = UInt.random()

    return CLLocationCoordinate2D(latitude: CLLocationDegrees(v % 180), longitude: CLLocationDegrees(w % 180))
}

internal func genDouble() -> Double {
    return Double.random()
}

internal func genString(_ len: Int) -> String {

    let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789你好吗😀🐱💥∆𝚹∌⌘"

    let randomString: NSMutableString = NSMutableString(capacity: len)

    for _ in 0..<len {
        let rand = Int.random(lower: 0, upper: letters.length)
        randomString.appendFormat("%C", letters.character(at: rand))
    }

    return randomString as String
}
