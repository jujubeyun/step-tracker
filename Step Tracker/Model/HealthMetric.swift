//
//  HealthMetric.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/11/24.
//

import Foundation

struct HealthMetric: Identifiable {
    let id = UUID()
    let date: Date // x axis
    let value: Double // y axis
}
