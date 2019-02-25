//
//  ViewController.swift
//  Flat Surfaces AR
//
//  Created by MICHAEL on 2019-02-24.
//  Copyright © 2019 Michael Truong. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
    
        // Set the scene to the view
//        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Enable vertical plane detection
        configuration.planeDetection = [.vertical]

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    private func createWall(on planeAnchor: ARPlaneAnchor) -> SCNNode {
        let node = SCNNode()
        
        // Create an object based on the size of the plane detected
        let geometry = SCNPlane(width: CGFloat(planeAnchor.extent.x),
                                height: CGFloat(planeAnchor.extent.z))
        geometry.firstMaterial?.diffuse.contents = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.25)
        node.geometry = geometry
        
        node.eulerAngles.x = -Float.pi / 2
        node.opacity = 1
        
        return node
    }
    
    private func createPainting(with image: UIImage) -> SCNNode {
//        let scale = SCNVector3(0.0005, 0.0005, 0.0005)
        
        let frameNode = SCNNode()
//        let imageNode = SCNScene(named: "art.scnassets/ship.scn")!.rootNode.clone()
//        print("w:\(image.size.width) h:\(image.size.height)")
        let frameWidth = CGFloat((image.size.width + 100)/2000)
        let frameHeight = CGFloat((image.size.height + 100)/2000)
        let frameGeometry = SCNBox(width: frameWidth, height: frameHeight, length: 0.05, chamferRadius: 0.0)
        frameGeometry.firstMaterial?.diffuse.contents = UIColor.brown
        frameNode.geometry = frameGeometry
//        frameNode.scale = scale
        
        let imageNode = SCNNode()
        let imageWidth = CGFloat((image.size.width)/2000)
        let imageHeight = CGFloat((image.size.height)/2000)
        let imageGeometry = SCNPlane(width: imageWidth, height: imageHeight)
        imageGeometry.firstMaterial?.diffuse.contents = image
        imageNode.geometry = imageGeometry
//        imageNode.scale = scale
        imageNode.position = SCNVector3(0, 0, 0.050125)
        
        frameNode.addChildNode(imageNode)
        
        
//        let imageNode = SCNScene(named: "art.scnassets/painting.scn")!.rootNode.clone()
//        frameNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        return frameNode
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // Ensures that we received a vertical plane
        guard let planeAnchor = anchor as? ARPlaneAnchor, planeAnchor.alignment == .vertical else {
            return
        }
        
        if let image = UIImage(named: "art.scnassets/jmb-self-portrait.jpg") {
            print("FOUND! A vertical plane has been detected")
            let wall = createWall(on: planeAnchor)
            node.addChildNode(wall)
            print("Here")
            
            let ship = createPainting(with: image)
            wall.addChildNode(ship)
            node.addChildNode(wall)
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            planeAnchor.alignment == .vertical else { return }
        
        /* Enlarged anchor detection
         We proceed to update the attached node's (Wall) position and size */
        for node in node.childNodes {
            node.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
            if let plane = node.geometry as? SCNPlane {
                plane.width = CGFloat(planeAnchor.extent.x)
                plane.height = CGFloat(planeAnchor.extent.z)
            }
            
        }
    }
    
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
