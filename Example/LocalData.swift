import UIKit
import SnapPageableArray

import CoreLocation // filler support

struct LocalData {

    let id: UInt64?
    let color: UIColor

    // fillers to learn more about performance

    let valA: UInt64?
    var valB: String
    var valC: TypeB

    let valD: TypeA?
    var valE: TypeC
    let valF: TypeD
    var valG: TypeE
    var valH: TypeF
    let valI: TypeE?

    let valJ: Bool
    var valK: Bool
    var valM: Bool
    let valN: Bool
    let valO: Bool
    let valP: Bool
    let valQ: Bool

    var valR: Bool

    let valS: UInt
    let valT: UInt
    let valU: UInt

    init(id: UInt64?, color: UIColor) {
        self.id = id
        self.color = color

        valA = genId()
        valB = genString(Int.random(lower: 3, upper: 19))
        valC = TypeB()
        valD = TypeA()
        valE = TypeC()
        valF = TypeD()
        valG = TypeE()
        valH = TypeF()
        valI = TypeE()
        valJ = genBool()
        valK = genBool()
        valM = genBool()
        valN = genBool()
        valO = genBool()
        valP = genBool()
        valQ = genBool()
        valR = genBool()
        valS = UInt.random()
        valT = UInt.random()
        valU = UInt.random()


    }

}

extension LocalData: DTOProtocol {

    var cacheId: String? {
        get {
            let theId = self.id ?? 0
            return "cacheId-\(theId)"
        }
    }
}
