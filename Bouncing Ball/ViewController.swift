//
//  ViewController.swift
//  Bouncing Ball
//
//  Created by David Rottenfusser on 2014-06-03.
//  Copyright (c) 2014 David Rottenfusser. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet var ball : UIImageView
    
    let radius = 25.0
    let interval = 0.02
    let bounciness = 0.9
    let friction = 0.0001
    let accelScale = 3600.0
    var x  = 0.0, y  = 0.0
    var dx = 100.0, dy = -100.0
    var ax = 0.0, ay = 1000.0
    
    var accel = CMMotionManager()
    
    func runTimer(theTimer: NSTimer) {
        let accelData = accel.accelerometerData?.acceleration
        if (accelData) {
            ax = Double(accelData!.x) * accelScale
            ay = Double(accelData!.y) * -accelScale
        }

        dx = dx * (1 - friction) + ax * interval
        dy = dy * (1 - friction) + ay * interval

        x += dx * interval
        y += dy * interval
        
        let bounds = self.view.frame
        let minX = Double(bounds.minX) + radius
        let minY = Double(bounds.minY) + radius
        let maxX = Double(bounds.maxX) - radius
        let maxY = Double(bounds.maxY) - radius
        if x < minX {
            x = minX * 2 - x
            dx -= ax * interval
            dx = abs(dx) * bounciness
        } else if x > maxX {
            x = maxX * 2 - x
            dx -= ax * interval
            dx = -abs(dx) * bounciness
        }
        if y < minY {
            y = minY * 2 - y
            dy -= ay * interval
            dy = abs(dy) * bounciness
        } else if y > maxY {
            y = maxY * 2 - y
            dy -= ay * interval
            dy = -abs(dy) * bounciness
        }
        
        
        UIView.animateWithDuration(interval, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.ball.center = CGPoint(x: Int(self.x), y: Int(self.y)) }, completion: nil)

    }
    
    func demoAccel(theTimer: NSTimer) {
        ax = (drand48() * 2 - 1) * accelScale
        ay = (drand48() * 2 - 1) * accelScale
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        x = Double(ball.center.x)
        y = Double(ball.center.y)
        
        accel.startAccelerometerUpdates()
        if (accel.accelerometerAvailable) {
            dx = 0
            dy = 0
        } else {
            NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "demoAccel:", userInfo: nil, repeats: true)
        }
        NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "runTimer:", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

