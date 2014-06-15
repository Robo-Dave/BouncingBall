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
    
    var bounciness = 0.9
    var friction = 0.1
    var gravity = 9.8
    var showStats = true
    
    var accelTimer: NSTimer?
    var scene: BallScene!
    
    @IBAction func AddButton(sender : AnyObject) {
        scene.newBall()
    }
    
    func setPhysics() {
        if !scene { return }
        
        scene.gravity = gravity
        scene.bounciness = bounciness
        scene.enumerateChildNodesWithName("ball") {
            (node, stop) in
            node.physicsBody.linearDamping = CGFloat(self.friction)
            node.physicsBody.restitution = CGFloat(self.bounciness)
        }
    }
    
    func demoAccel(theTimer: NSTimer) {
        let ax = (drand48() * 2 - 1) * gravity
        let ay = (drand48() * 2 - 1) * gravity
        scene.physicsWorld.gravity = CGVectorMake(CGFloat(ax),CGFloat(ay))
    }
    
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
        }
        spriteView.presentScene(scene)
        setPhysics()
        
        if !(CMMotionManager().accelerometerAvailable) {
            accelTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "demoAccel:", userInfo: nil, repeats: true)
            demoAccel(accelTimer!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        let settingsView = segue!.destinationViewController as SettingsViewController
        settingsView.mainView = self
        //(view as SKView).presentScene(nil)
        
        accelTimer?.invalidate()
    }
}

