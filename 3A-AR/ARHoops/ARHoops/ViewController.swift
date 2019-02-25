//
//  ViewController.swift
//  ARHoops
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
        sceneView.debugOptions = [.showFeaturePoints]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical]
        

        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func addHoop(result: ARHitTestResult) {
        let hoopScene = SCNScene(named: "art.scnassets/hoop.scn")
        
        guard let hoopNode = hoopScene?.rootNode.childNode(withName: "Hoop", recursively: false) else {
            return
        }
        
        // Place the node at the user's touch
        let planePosition = result.worldTransform.columns.3
        hoopNode.position = SCNVector3(planePosition.x, planePosition.y, planePosition.z)
        
        // Add node to the scene
        sceneView.scene.rootNode.addChildNode(hoopNode)
    }
    
    func moveHoop(result: SCNHitTestResult) {
        for node in sceneView.scene.rootNode.childNodes {
            if node.name == "Hoop" {
                let planePosition = result.modelTransform.
                node.position = SCNVector3(planePosition.x, planePosition.y, planePosition.z - 0.05)
            }
        }
    }
    
    func levitateHoop(result: SCNHitTestResult) {
        for node in sceneView.scene.rootNode.childNodes {
            if node.name == "Hoop" {
                // Lift the hoop by 5cm
                SCNTransaction.animationDuration = 0.5
                node.position.z = node.position.z - 0.05
            }
        }
    }
    
    func placeHoopDown(result: SCNHitTestResult) {
        for node in sceneView.scene.rootNode.childNodes {
            if node.name == "Hoop" {
                // Place the hoop back onto the plane
                SCNTransaction.animationDuration = 0.5
                node.position.z = node.position.z + 0.05
            }
        }
    }
    
    // MARK: Tap Gesture Actions
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, types: [.existingPlaneUsingExtent])
        
        if let result = hitTestResult.first {
            addHoop(result: result)
        }
    }
    
    @IBAction func dragScreenTap(_ sender: UIPanGestureRecognizer) {
        let touchLocation = sender.location(in: sceneView)
        let hitTestResult = sceneView.hitTest(touchLocation, options: nil)
        
        print("HERE?")
        
        if let result = hitTestResult.first {
            if sender.state == .began {
                // TODO: Lift the item..
                print("Gesture beginning")
            } else if sender.state == .changed {
                print("Moving hoop")
                moveHoop(result: result)
            } else if sender.state == .ended {
                print("Gesture ended")
                placeHoopDown(result: result)
            }
        }
    }
    
    
    // MARK: - ARSCNViewDelegate
    
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
