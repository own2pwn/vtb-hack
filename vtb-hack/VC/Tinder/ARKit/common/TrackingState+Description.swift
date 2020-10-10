import ARKit

extension ARCamera.TrackingState {
    public var description: String {
        switch self {
        case .notAvailable:
            return "TRACKING UNAVAILABLE"
        case .normal:
            return "TRACKING NORMAL"
        case let .limited(reason):
            switch reason {
            case .excessiveMotion:
                return "TRACKING LIMITED\nToo much camera movement"
            case .insufficientFeatures:
                return "TRACKING LIMITED\nNot enough surface detail"
            case .initializing:
                return "TRACKING LIMITED\nInitialization in progress."
            case .relocalizing:
                return "TRACKING LIMITED\nRelocalization in progress."
            @unknown default:
                fatalError()
            }
        }
    }
}
