//
//  HealthKitManager.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/10/24.
//

import HealthKit

@Observable final class HealthKitManager {
    let store = HKHealthStore()
    
    let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
