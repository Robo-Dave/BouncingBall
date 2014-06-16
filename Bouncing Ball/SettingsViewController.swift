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
    
    var mainView: ViewController?
    
    // sets number of balls back to 1
    @IBAction func ResetBalls(sender : AnyObject) {
        let delegate = UIApplication.sharedApplication().delegate as AppDelegate
        delegate.scene?.removeAllChildren()
        delegate.scene?.newBall()
    } // func ResetBalls

    
    // load parameters from main view
    override func viewDidLoad() {
        super.viewDidLoad()

        if mainView {
            BouncinessSlider.value = CFloat(mainView!.bounciness)
            FrictionSlider.value = CFloat(mainView!.friction)
            GravitySlider.value = CFloat(mainView!.gravity)
            StatsSwitch.on = mainView!.showStats
        } // if
    } // func viewDidLoad

    
    // save parameters back to main view
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        let mainView = segue!.destinationViewController as ViewController
        mainView.bounciness = Double(BouncinessSlider.value)
        mainView.friction   = Double(FrictionSlider.value)
        mainView.gravity = Double(GravitySlider.value)
        mainView.showStats = StatsSwitch.on
    } // func prepareForSegue

} // class SettingsViewController
