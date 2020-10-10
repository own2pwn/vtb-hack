import ARKit
import SceneKit
import UIKit

final class CarDemoViewController: UIViewController, ARSCNViewDelegate {
    private let sceneView = ARSCNView()

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sceneView)

        NSLayoutConstraint.activate([
            sceneView.topAnchor.constraint(equalTo: view.topAnchor),
            sceneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sceneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        sceneView.delegate = self
        sceneView.scene = SCNScene()
        sceneView.debugOptions = [SCNDebugOptions.showFeaturePoints]
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let frame = sceneView.session.currentFrame else { return }
        sceneView.updateLightingEnvironment(for: frame)
    }

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { assertionFailure(); return }
        planeAnchor.addPlaneNode(on: node, contents: UIColor.arBlue.withAlphaComponent(0.3))

        let virtualNode = VirtualObjectNode()
        DispatchQueue.main.async {
            node.addChildNode(virtualNode)
        }
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { assertionFailure(); return }
        planeAnchor.updatePlaneNode(on: node)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {}
}
