//
//  SettingsViewController.swift
//  Bouncing Ball
//
//  Created by David Rottenfusser on 2014-06-07.
//  Copyright (c) 2014 David Rottenfusser. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet var BouncinessSlider : UISlider
    @IBOutlet var FrictionSlider   : UISlider
    @IBOutlet var GravitySlider    : UISlider
    @IBOutlet var StatsSwitch      : UISwitch
    
    let app = UIApplication.sharedApplication().delegate as AppDelegate
    
    // sets number of balls back to 1
    @IBAction func ResetBalls(sender : AnyObject) {
        app.scene?.removeAllChildren()
        app.scene?.newBall()
    } // func ResetBalls

    
    // load parameters from main view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BouncinessSlider.value = CFloat(app.bounciness)
        FrictionSlider.value = CFloat(app.friction)
        GravitySlider.value = CFloat(app.gravity)
        StatsSwitch.on = app.showStats
    } // func viewDidLoad

    
    // save parameters back to main view
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        app.bounciness = Double(BouncinessSlider.value)
        app.friction = Double(FrictionSlider.value)
        app.gravity = Double(GravitySlider.value)
        app.showStats = StatsSwitch.on
    } // func prepareForSegue

} // class SettingsViewController
