//
//  DiceRollViewController.swift
//  Test03
//
//  Created by Andrew Matula on 7/7/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import UIKit
import SceneKit

class DiceRollViewController: UIViewController {
    
    var SceneWindow: SCNView!
    var scene: SCNScene!
    
    var diceNode: SCNNode!
    var cameraNode: SCNNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        setupNodes()
        diceSkin()

    }
    func setupScene() {
        scene = SCNScene(named: "mainScene.scn")
        SceneWindow = self.view as? SCNView
        SceneWindow.delegate = self
        SceneWindow.scene = scene
        SceneWindow.allowsCameraControl = false
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(throwDice))
        swipe.direction = .up
        SceneWindow.addGestureRecognizer(swipe)
    }
    
    func setupNodes() {
        diceNode = scene.rootNode.childNode(withName: "dice", recursively: true)!
        cameraNode = scene.rootNode.childNode(withName: "mainCamera", recursively: true)!
    }
    
    func diceSkin() {
        let normalSkin = "DiceNormal03.jpg"
        let side1 = SCNMaterial()
        side1.diffuse.contents = UIImage(named: "DiceSide01.jpg")
        side1.normal.contents = UIImage(named: normalSkin)
        
        let side2 = SCNMaterial()
        side2.diffuse.contents = UIImage(named: "DiceSide02.jpg")
        side2.normal.contents = UIImage(named: normalSkin)
        
        let side3 = SCNMaterial()
        side3.diffuse.contents = UIImage(named: "DiceSide03.jpg")
        side3.normal.contents = UIImage(named: normalSkin)
        
        let side4 = SCNMaterial()
        side4.diffuse.contents = UIImage(named: "DiceSide04.jpg")
        side4.normal.contents = UIImage(named: normalSkin)
        
        let side5 = SCNMaterial()
        side5.diffuse.contents = UIImage(named: "DiceSide05.jpg")
        side5.normal.contents = UIImage(named: normalSkin)
        
        let side6 = SCNMaterial()
        side6.diffuse.contents = UIImage(named: "DiceSide06.jpg")
        side6.normal.contents = UIImage(named: normalSkin)
        
        diceNode.geometry?.materials = [side1, side2, side3, side4, side5, side6]
    }
    
    @objc func throwDice(){
        let forcePos = SCNVector3(x: Float.random(in: -0.2 ... 0.2), y: Float.random(in: -0.2 ... 0.2), z: Float.random(in: -0.2 ... 0.2))
        let forceApp = SCNVector3(x: 0, y: Float.random(in: 2 ... 4), z: 0)
        diceNode.physicsBody?.applyForce(forceApp, at: forcePos, asImpulse: true)
        
        }
        
    override var shouldAutorotate: Bool{
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension DiceRollViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {

        let dicePos = diceNode.presentation.position
        let cameraPos = cameraNode.presentation.position
        
        let targetPos = SCNVector3(x: dicePos.x , y: dicePos.y, z: dicePos.z)
        let cameraDamp: Float = 0.2

        let xComp = cameraPos.x * (1 - cameraDamp) + targetPos.x * cameraDamp
        let yComp = cameraPos.y * (1 - cameraDamp) + targetPos.y * cameraDamp
        let zComp = cameraPos.z * (1 - cameraDamp) + targetPos.z * cameraDamp
        let newPos = SCNVector3(x: xComp, y: yComp, z: zComp)
        cameraNode.position = newPos
    }
}
