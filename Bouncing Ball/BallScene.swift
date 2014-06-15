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

@assignment func /= (inout left:CGSize, right:CGFloat) {
    left.height /= right
    left.width /= right
} // func /=

class BallScene: SKScene {
    
    var gravity = 9.8
    var bounciness = 0.9
    let accel = CMMotionManager()
    
    override func didMoveToView(view: SKView!) {
        super.didMoveToView(view)
        self.backgroundColor = SKColor.whiteColor()
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVector(0, CGFloat(-gravity))
        
        accel.startAccelerometerUpdatesToQueue(NSOperationQueue()) {
            (data, err) in
            if (err) {
                self.accel.stopAccelerometerUpdates()
            } else {
                let dx = CGFloat(data.acceleration.x * self.gravity)
                let dy = CGFloat(data.acceleration.y * self.gravity)
                self.physicsWorld.gravity = CGVector(dx,dy)
            } // else
            NSOperationQueue.currentQueue().cancelAllOperations()
        } // startAccelerometerUpdatesToQueue

    } // func didMovetoView
    
    override func willMoveFromView(view: SKView!) {
        accel.stopAccelerometerUpdates()
        super.willMoveFromView(view)
    } // func willMoveFromView
    
    func randomImpulse(size:Double) -> CGVector {
        let dx = drand48() * 2 - 1
        let dy = drand48() * 2 - 1
        return CGVectorMake(CGFloat(dx*size), CGFloat(dy*size))
    } // func randomImpulse
    
    func newBall() {
        let ball = SKSpriteNode(imageNamed:"circle-100.png")
        ball.position = CGPoint(x:frame.midX, y:frame.midY)
        ball.size /= 2
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody.restitution = CGFloat(bounciness)
        self.addChild(ball)
        ball.physicsBody.applyImpulse(randomImpulse(100))
    } // func newBall

} // class BallScene