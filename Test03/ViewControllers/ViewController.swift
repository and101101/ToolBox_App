//
//  ViewController.swift
//  Test03
//
//  Created by Andrew Matula on 6/11/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var ButtonGPS: UIButton!
    @IBOutlet weak var ButtonSched: UIButton!
    @IBOutlet weak var ButtonHourly: UIButton!
    @IBOutlet weak var ButtonDice: UIButton!
    
    var buttArray: [UIButton] = [UIButton]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttArray = [self.ButtonGPS,self.ButtonSched,self.ButtonHourly,self.ButtonDice]
        for butt in buttArray{
            butt.alpha = 0
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var delayTime = 0.50
        for butt in buttArray{
            UIView.animate(withDuration: 0.40, delay: delayTime, animations: {
                butt.alpha = 1
            }, completion: nil)
            delayTime += 0.40
        }
    }
}



