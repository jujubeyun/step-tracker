//
//  ChartDataTypes.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/12/24.
//

import Foundation

struct DateValueChartData: Identifiable, Equatable {
    let id = UUID()
    let date: Date
    let value: Double
}
