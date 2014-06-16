//
//  ViewController.swift
//  Bouncing Ball
//
//  Created by David Rottenfusser on 2014-06-03.
//  Copyright (c) 2014 David Rottenfusser. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class ViewController: UIViewController {
    
    var bounciness = 0.9 // ratio (0-1)
    var friction = 0.1   // ratio (0-1)
    var gravity = 9.8    // m/s²
    var showStats = true
    
    var accelTimer: NSTimer? // used when accelerometer isn't available
    var scene: BallScene!
    
    
    // called when (+) button is tapped
    @IBAction func AddButton(sender : AnyObject) {
        scene.newBall()
    } // func AddButton
    
    
    // updates model with new phyiscal parameters
    func setPhysics() {
        if !scene { return }
        
        scene.gravity = gravity
        scene.bounciness = bounciness
        scene.enumerateChildNodesWithName("ball") {
            (node, stop) in
            node.physicsBody.linearDamping = CGFloat(self.friction)
            node.physicsBody.restitution = CGFloat(self.bounciness)
        } // enumerateChildNodesWithName
    } // func setPhysics
    
    
    // sets gravity to a random vector (used when accelerometer isn't present)
    func demoAccel(theTimer: NSTimer) {
        let ax = (drand48() * 2 - 1) * gravity
        let ay = (drand48() * 2 - 1) * gravity
        scene.physicsWorld.gravity = CGVectorMake(CGFloat(ax),CGFloat(ay))
    } // func demoAccel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let spriteView = self.view as SKView
        spriteView.showsDrawCount = showStats
        spriteView.showsNodeCount = showStats
        spriteView.showsFPS = showStats
        
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        if (delegate.scene) {
            scene = delegate.scene
        } else {
            scene = BallScene(size:CGSize(width:view.bounds.width,height:view.bounds.height))
            scene.newBall()
            delegate.scene = scene
        } // else
        
        spriteView.presentScene(scene)
        setPhysics()
        
        if !(CMMotionManager().accelerometerAvailable) {
            accelTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "demoAccel:", userInfo: nil, repeats: true)
            demoAccel(accelTimer!)
        } // if
    } // func viewDidLoad

    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        let settingsView = segue!.destinationViewController as SettingsViewController
        settingsView.mainView = self
        accelTimer?.invalidate()
    } // func prepareForSegue

} // class ViewController

