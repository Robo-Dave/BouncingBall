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
    }
   
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch
        position = touch.locationInNode(parent)
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        physicsBody.dynamic = true
    }
    
    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
        physicsBody.dynamic = true
    }
}
