public enum DTOState {
    case unavailable
    case requested(timestamp: TimeInterval) // times out after 5 seconds
    case available

    func isAvailable() -> Bool {
        switch(self) {
        case .available: return true
        default: return false
        }
    }

    func isUnavailable() -> Bool {
        switch(self) {
        case .unavailable: return true
        default: return false
        }
    }

    func hasTimedOut(timestamp newTimeStamp: TimeInterval) -> Bool {
        switch(self) {
        case let .requested(timestamp):
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
