public protocol DTOProtocol: CacheableDTO {
    var id: UInt64? { get }
}

extension DTOProtocol {
    public var cacheId: String? {
        if let id = id {
            let cacheId = "\(Self.self)-\(id)"
            return cacheId
        }
        return nil
    }

    public static func cacheId(id id: UInt64) -> String {
        let cacheId = "\(Self.self)-\(id)"
        return cacheId
    }
}
