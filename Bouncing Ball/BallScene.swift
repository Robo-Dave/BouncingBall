//
//  BallScene.swift
//  Bouncing Ball
//
//  Created by David Rottenfusser on 2014-06-15.
//  Copyright (c) 2014 David Rottenfusser. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

// Runs the bouncing balls and their physics environment.
class BallScene: SKScene {
    
    let accel = CMMotionManager()
    let app = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        self.backgroundColor = SKColor.whiteColor()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVector(0, CGFloat(-app.gravity))
        
        accel.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler:accelUpdate)
    } // func didMovetoView

    
    override func willMoveFromView(view: SKView!) {
        accel.stopAccelerometerUpdates()
        super.willMoveFromView(view)
    } // func willMoveFromView
    
    
    // runs whenever accelerometer data is available
    func accelUpdate(data: CMAccelerometerData!, err: NSError!) {
        if (err) {
            accel.stopAccelerometerUpdates()
        } else {
            let dx = CGFloat(data.acceleration.x * app.gravity)
            let dy = CGFloat(data.acceleration.y * app.gravity)
            self.physicsWorld.gravity = CGVector(dx,dy)
        } // else
        
        // we only need one update at a time
        NSOperationQueue.currentQueue().cancelAllOperations()
    } // func accelUpdate
    

    // updates model with new phyiscal parameters
    func setPhysics() {
        scene.enumerateChildNodesWithName("ball") {
            (node, stop) in
            node.physicsBody.linearDamping = CGFloat(self.app.friction)
            node.physicsBody.restitution = CGFloat(self.app.bounciness)
        } // enumerateChildNodesWithName
    } // func setPhysics

    
    func randomImpulse(size:Double) -> CGVector {
        let dx = drand48() * 2 - 1
        let dy = drand48() * 2 - 1
        return CGVectorMake(CGFloat(dx*size), CGFloat(dy*size))
    } // func randomImpulse
    

    func newBall() {
        let ball = Ball()
        ball.position = CGPoint(x:frame.midX, y:frame.midY)
        self.addChild(ball)
        ball.physicsBody.applyImpulse(randomImpulse(100))
    } // func newBall

} // class BallScene
