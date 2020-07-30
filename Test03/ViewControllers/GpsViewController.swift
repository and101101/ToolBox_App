//
//  GpsViewController.swift
//  Test03
//
//  Created by Andrew Matula on 6/12/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class GpsViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    @IBOutlet weak var LatUI: UILabel!
    @IBOutlet weak var LongUI: UILabel!
    @IBOutlet weak var AltUI: UILabel!
    @IBOutlet weak var AccUI: UILabel!
    @IBOutlet weak var VelUI: UILabel!
    
    var labelArray: [UILabel] = [UILabel]()
    
    var UserLong = ""
    var UserLat = ""
    var UserAlt = ""
    var UserAcc = ""
    var UserVel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelArray = [self.LatUI,self.LongUI,self.AltUI,self.AccUI,self.VelUI]
        for label in labelArray {
            label.alpha = 0
        }
        setupLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for label in labelArray {
            UIView.animate(withDuration: 1) {
                label.alpha = 1
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        for currentLocations in locations {
            print("\(currentLocations)")
            UserLong = "\(currentLocations.coordinate.longitude)"
            UserLat = "\(currentLocations.coordinate.latitude)"
            UserAlt = "\(currentLocations.altitude)"
            UserAcc = "\(currentLocations.horizontalAccuracy)"
            UserVel = "\(currentLocations.speed)"
            loadLocationData()
        }
    }
    
    func setupLocation() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func loadLocationData() {
        LongUI.text = UserLong
        LatUI.text = UserLat
        AltUI.text = UserAlt + " m"
        AccUI.text = "+/- " + UserAcc + " m"
        VelUI.text = UserVel + " m/s"
    }

    
    @IBAction func copyLoc(_ sender: Any) {
        let paste = UIPasteboard.general
        if UserLat != "" && UserLong != "" {
            paste.string = "\(UserLat)" + "," + "\(UserLong)"
        }
    }
    
    @IBAction func copyAlt(_ sender: Any) {
        let paste = UIPasteboard.general
        if UserAlt != ""{
            paste.string = "\(UserAlt)" + "m"
        }
    }
    
    @IBAction func dismissTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
