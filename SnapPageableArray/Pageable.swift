import Foundation

public struct Pageable {

    public let page: UInt
    public let pageSize: UInt

    public init(page: UInt = 0, pageSize: UInt = 40) {
        self.page = page
        self.pageSize = pageSize
    }

    public func nextPage() -> Pageable {
        return Pageable(page: page + 1, pageSize: pageSize)
    }

    public var startItemIndex: UInt {
        get {
            return page * pageSize
        }
    }

    public var endItemIndex: UInt {
        get {
            return ((page + 1) * pageSize) - 1
        }
    }

}

extension Pageable : DictConvertible {

    public init(dict: [String : Any]) throws {
        guard let page_ = dict["page"] as? UInt,
            let pageSize_ = dict["pageSize"] as? UInt else {
                throw DictConvertibleError.invalidDict
        }

        page = page_
        pageSize = pageSize_
    }


    public func toDict() -> [String:Any] {
        return [
            "page": page,
            "pageSize": pageSize
        ]
    }
}
