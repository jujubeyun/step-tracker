//
//  Step_TrackerApp.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/6/24.
//

import SwiftUI

@main
struct Step_TrackerApp: App {
    
    let hkManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environment(hkManager)
        }
    }
}
