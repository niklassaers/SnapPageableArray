import Foundation
import SnapPageableArray
import CoreLocation

// filler supporting structs
struct TypeA {
    let A: CLLocationCoordinate2D?
    let B: CLLocationAccuracy?
    let C: Double

    init() {
        A = genOptCoordinate()
        B = genDouble()
        C = genDouble()
    }
}

struct TypeB: DTOProtocol {
    let id: UInt64?
    var B: URL?
    var C: UIImage?

    init() {
        id = genId()
        B = genOptImageUrl() as URL?
        C = nil
    }
}

struct TypeC {

    let A: UInt64
    let B: String
    let C: String
    var D: Bool
    let E: Bool?
    let F: Int?
    let G: URL?
    var H: UIImage? = nil
    fileprivate(set) var I: TypeI? = nil

    init() {
        A = genId()
        B = genString(Int.random(lower: 3, upper: 19))
        C = genString(Int.random(lower: 3, upper: 19))
        D = genBool()
        E = genOptBool()
        F = genOptInt()
        G = genOptImageUrl() as URL?
        H = nil
        I = TypeI()
    }
}

struct TypeD {

    let A: Date
    let B: Date
    let C: Date
    let D: Date

    init() {
        A = Date(timeIntervalSinceNow: genDouble())
        B = Date(timeIntervalSinceNow: genDouble())
        C = Date(timeIntervalSinceNow: genDouble())
        D = Date(timeIntervalSinceNow: genDouble())
    }
}

struct TypeE {

    var A: UInt64
    let B: UInt64
    let C: UInt64?
    var D: TypeH

    init() {
        A = UInt64.random()
        B = UInt64.random()
        C = UInt64.random()
        D = TypeH()
    }
}

struct TypeF {

    var A: [TypeJ]
    let B: Bool

    init() {
        A = [TypeJ(), TypeJ()]
        B = genBool()
    }
}

struct TypeG {

    let A: TypeE
    let B: EnumA
    let C: UInt
    let D: UInt
    let E: UInt64
    let F: String?
    let G: Bool?
    let H: Bool?

    init() {
        A = TypeE()
        B = EnumA(rawValue: Int.random(lower: 0, upper: 5)) ?? EnumA.a
        C = UInt.random()
        D = UInt.random()
        E = UInt64.random()
        F = genString(Int.random(lower: 3, upper: 19))
        G = genOptBool()
        H = genOptBool()
    }
}

enum EnumA: Int {
    case a = 0
    case b = 1
    case c = 2
    case d = 3
    case e = 4
    case f = 5
}

struct TypeH {
    let A: String
    let B: String
    let C: String

    init() {
        A = genString(Int.random(lower: 3, upper: 19))
        B = genString(Int.random(lower: 3, upper: 19))
        C = genString(Int.random(lower: 3, upper: 19))

    }
}

struct TypeI: DTOProtocol {

    let id: UInt64?
    var B: TypeK
    var C: String
    var D: String
    var E: String
    var F: TypeB?
    var G: Bool
    let H: Date
    let I: EnumB
    let J: String
    var K: Bool
    let L: Bool
    var M: Bool
    let N: Bool
    var O: Bool
    let P: Bool
    let Q: Bool
    let R: UInt
    let S: UInt
    let T: UInt
    let U: UInt
    let V: UInt64
    let W: String
    var X: [TypeL]
    let Y: [String]
    let Z: [String]

    init() {
        id = genId()
        B = TypeK()
        C = genString(Int.random(lower: 3, upper: 19))
        D = genString(Int.random(lower: 3, upper: 19))
        E = genString(Int.random(lower: 3, upper: 19))
        F = TypeB()
        G = genBool()
        H = Date(timeIntervalSinceNow: genDouble())
        I = EnumB.random()
        J = genString(Int.random(lower: 3, upper: 19))
        K = genBool()
        L = genBool()
        M = genBool()
        N = genBool()
        O = genBool()
        P = genBool()
        Q = genBool()
        R = UInt.random()
        S = UInt.random()
        T = UInt.random()
        U = UInt.random()
        V = UInt64.random()
        W = genString(Int.random(lower: 3, upper: 19))
        X = [TypeL(), TypeL()]
        Y = [genString(Int.random(lower: 3, upper: 6)), genString(Int.random(lower: 3, upper: 6)), genString(Int.random(lower: 3, upper: 6))]
        Z = [genString(Int.random(lower: 3, upper: 6)), genString(Int.random(lower: 3, upper: 6)), genString(Int.random(lower: 3, upper: 6))]

    }
}

enum EnumB: String {
    case A
    case B = "B-value"
    case C = "C-value"

    static func random() -> EnumB {
        switch Int.random(lower: 0, upper: 2) {
        case 0:
            return EnumB.A

        case 1:
            return EnumB.B

        default:
            return EnumB.C
        }
    }
}

struct TypeJ {
    let A: String
    var B: EnumC

    init() {
        A = genString(Int.random(lower: 3, upper: 19))
        B = EnumC(rawValue: Int.random(lower: 0, upper: 2)) ?? EnumC.a
    }
}

public enum EnumC: Int {
    case a = 0
    case b
    case c
}


struct TypeK {

    var A: Bool
    var B: String?
    var C: Bool?

    init() {
        A = genBool()
        B = genString(Int.random(lower: 3, upper: 19))
        C = genOptBool()
    }
}

struct TypeL {

    let A: EnumD
    let B: String
    let C: String

    init() {
        A = EnumD.random()
        B = genString(Int.random(lower: 3, upper: 19))
        C = genString(Int.random(lower: 3, upper: 19))
    }
}

enum EnumD: String {
    case A = "A-value"
    case B = "B-value"
    case C

    static func random() -> EnumD {
        switch Int.random(lower: 0, upper: 2) {
        case 0:
            return EnumD.A

        case 1:
            return EnumD.B

        default:
            return EnumD.C
        }
    }

}
