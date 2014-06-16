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
    
    let app = UIApplication.sharedApplication().delegate as AppDelegate
    
    var accelTimer: NSTimer? // used when accelerometer isn't available
    var scene: BallScene!
    
    
    // called when (+) button is tapped
    @IBAction func AddButton(sender : AnyObject) {
        scene.newBall()
    } // func AddButton
    
    
    // sets gravity to a random vector (used when accelerometer isn't present)
    func demoAccel(theTimer: NSTimer) {
        let ax = (drand48() * 2 - 1) * app.gravity
        let ay = (drand48() * 2 - 1) * app.gravity
        scene.physicsWorld.gravity = CGVectorMake(CGFloat(ax),CGFloat(ay))
    } // func demoAccel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // enable stats
        let spriteView = self.view as SKView
        spriteView.showsDrawCount = app.showStats
        spriteView.showsNodeCount = app.showStats
        spriteView.showsFPS = app.showStats
        
        // get scene, or create new one
        if (app.scene) {
            scene = app.scene
        } else {
            scene = BallScene(size:CGSize(width:view.bounds.width,height:view.bounds.height))
            scene.newBall()
            app.scene = scene
        } // else
        
        // start simulation
        spriteView.presentScene(scene)
        scene.setPhysics()
        
        // start gravity randomizer if actual gravity isn't available
        if !(CMMotionManager().accelerometerAvailable) {
            accelTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "demoAccel:", userInfo: nil, repeats: true)
            demoAccel(accelTimer!)
        } // if
    } // func viewDidLoad

    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        accelTimer?.invalidate()
    } // func prepareForSegue

} // class ViewController

