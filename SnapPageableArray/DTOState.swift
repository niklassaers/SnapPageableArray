enum DTOState {
    case Unavailable
    case Requested(timestamp: NSTimeInterval) // times out after 5 seconds
    case Available

    func isAvailable() -> Bool {
        switch(self) {
        case .Available: return true
        default: return false
        }
    }

    func isUnavailable() -> Bool {
        switch(self) {
        case .Unavailable: return true
        default: return false
        }
    }

    func hasTimedOut(timestamp newTimeStamp: NSTimeInterval) -> Bool {
        switch(self) {
        case let .Requested(timestamp):
            let oldTimeStamp = timestamp

            if (newTimeStamp - oldTimeStamp) > 5 {
                return true
            } else {
                return false
            }
        default: return false
        }
    }

}
