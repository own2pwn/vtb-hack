import SceneKit

final class VirtualObjectNode: SCNNode {
    enum VirtualObjectType {
        case car
    }

    init(type: VirtualObjectType = .car) {
        super.init()

        var scale = 1.0
        switch type {
        case .car:
            loadDae(name: "McLaren")
            scale = 0.0008
        }
        self.scale = SCNVector3(scale, scale, scale)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    func react() {
        return;
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.3
        SCNTransaction.completionBlock = {
            SCNTransaction.animationDuration = 0.15
            self.opacity = 1.0
        }
        opacity = 0.5
        SCNTransaction.commit()
    }
}
