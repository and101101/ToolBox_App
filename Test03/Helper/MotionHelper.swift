//
//  MotionHelper.swift
//  Test03
//
//  Created by Andrew Matula on 7/17/20.
//  Copyright © 2020 Andrew Matula. All rights reserved.
//

import Foundation
import CoreMotion

class MotionHelper {
    
    let motionManager = CMMotionManager()
    
    init() {
        
    }
    
    func getAccelerometerData(interval: TimeInterval = 0.1, motionDataResults: ((_ x: Float, _ y:Float, _ z:Float) -> ())?){
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = interval
            motionManager.startAccelerometerUpdates(to: OperationQueue()) { (data,error) in
                if motionDataResults != nil {
                    motionDataResults!(Float(data!.acceleration.x), Float(data!.acceleration.y), Float(data!.acceleration.z))
                }
            }
        }
    }
}

