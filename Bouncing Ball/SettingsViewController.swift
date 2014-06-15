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
    @IBOutlet var FrictionSlider : UISlider
    @IBOutlet var GravitySlider : UISlider
    
    var mainView: ViewController?
    
    /*
    init(style: UITableViewStyle) {
        super.init(style: style)
        // Custom initialization
    }
    */

    override func viewDidLoad() {
        super.viewDidLoad()

        if mainView {
            BouncinessSlider.value = CFloat(mainView!.bounciness)
            FrictionSlider.value = CFloat(mainView!.friction)
            GravitySlider.value = CFloat(mainView!.accelScale)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.

        let mainView = segue!.destinationViewController as ViewController
        mainView.bounciness = Double(BouncinessSlider.value)
        mainView.friction   = Double(FrictionSlider.value)
        mainView.accelScale = Double(GravitySlider.value)
    }


}