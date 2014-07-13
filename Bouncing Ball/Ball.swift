//
//  Ball.swift
//  Bouncing Ball
//
//  Created by David Rottenfusser on 2014-06-15.
//  Copyright (c) 2014 David Rottenfusser. All rights reserved.
//

import UIKit
import SpriteKit

// convenience function, used in BallScene.newBall()
@assignment func /= (inout left:CGSize, right:CGFloat) {
    left.height /= right
    left.width /= right
} // func /=

@infix func - (left: CGPoint, right: CGPoint) -> CGVector {
    return CGVectorMake(left.x - right.x, left.y - right.y)
}

class Ball: SKSpriteNode {

    var lastPos: CGPoint!
    var lastTime: NSTimeInterval!
    var lastVelocity: CGVector!

    class func newBall() -> Ball {
        let app = UIApplication.sharedApplication().delegate as AppDelegate
        
        var ball = Ball(imageNamed:"circle-100.png")
        let size = ball.size;
        ball.size = CGSizeMake(size.width/2, size.height/2)
        ball.name = "ball"
        var physicsBody = SKPhysicsBody(circleOfRadius: size.width / 4)
        physicsBody.restitution = CGFloat(app.bounciness)
        physicsBody.usesPreciseCollisionDetection = true
        ball.physicsBody = physicsBody
        ball.userInteractionEnabled = true
        return ball
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        physicsBody.dynamic = false
        lastPos = position
        lastTime = (touches.anyObject() as UITouch).timestamp
    }
   
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch
        position = touch.locationInNode(parent)
        
        let time = touch.timestamp
        let interval = CGFloat(time - lastTime)
        if (interval > 0) {
            lastVelocity = CGVectorMake((position.x - lastPos.x) / interval, (position.y - lastPos.y) / interval)
            lastPos = position
            lastTime = time
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        physicsBody.dynamic = true
        if (lastVelocity) {
            physicsBody.velocity = lastVelocity
            lastVelocity = nil
        }
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        physicsBody.dynamic = true
        if (lastVelocity) {
            physicsBody.velocity = lastVelocity
            lastVelocity = nil
        }
    }
}
