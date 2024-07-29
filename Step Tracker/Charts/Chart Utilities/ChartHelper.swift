//
//  ChartHelper.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/18/24.
//

import Foundation
import Algorithms

struct ChartHelper {
    /// Convert from array of ``HealthMetric`` to array of ``DateValueChartData``
    /// - Parameter data: array of ``HealthMetric`` to convert
    /// - Returns: array of ``DateValueChartData``
    static func convert(data: [HealthMetric]) -> [DateValueChartData] {
        data.map { .init(date: $0.date, value: $0.value) }
    }
    
    /// Finds selected date from array of ``DateValueChartData``
    /// - Parameters:
    ///   - data: Chart data array
    ///   - selectedDate: Date that user selected
    /// - Returns: Selected Date from array of ``DateValueChartData``
    static func parseSelectedData(from data: [DateValueChartData], in selectedDate: Date?) -> DateValueChartData? {
        guard let selectedDate else { return nil }
        return data.first {
            Calendar.current.isDate(selectedDate, inSameDayAs: $0.date)
        }
    }
    
    /// Calculate average weekday step count with array of ``HealthMetric``
    /// - Parameter metric: array of ``HealthMetric``
    /// - Returns: Array of weekdays' average step count
    static func averageWeekdayCount(for metric: [HealthMetric]) -> [DateValueChartData] {
        let sortedByWeekday = metric.sorted(using: KeyPathComparator(\.date.weekdayInt))
        let weekdayArray = sortedByWeekday.chunked { $0.date.weekdayInt == $1.date.weekdayInt }
        
        var weekdayChartData: [DateValueChartData] = []
        
        for array in weekdayArray {
            guard let firstValue = array.first else { continue }
            let total = array.reduce(0) { $0 + $1.value }
            let avgSteps = total / Double(array.count)
            weekdayChartData.append(.init(date: firstValue.date, value: avgSteps))
        }
        
        return weekdayChartData
    }
    
    /// Calculate average weekday weight difference with array of ``HealthMetric``
    /// - Parameter weights: array of ``HealthMetric``
    /// - Returns: Array of weekdays' average weight difference
    static func averageDailyWeightDiffs(for weights: [HealthMetric]) -> [DateValueChartData] {
        var diffValues: [(date: Date, value: Double)] = []
        
        guard weights.count > 1 else { return [] }
        for i in 1..<weights.count {
            let date = weights[i].date
            let diff = weights[i].value - weights[i-1].value
            diffValues.append((date: date, value: diff))
        }
                
        let sortedByWeekday = diffValues.sorted(using: KeyPathComparator(\.date.weekdayInt))
        let weekdayArray = sortedByWeekday.chunked { $0.date.weekdayInt == $1.date.weekdayInt }
        
        var weekdayChartData: [DateValueChartData] = []
        
        for array in weekdayArray {
            guard let firstValue = array.first else { continue }
            let total = array.reduce(0) { $0 + $1.value }
            let avgWeightDiff = total / Double(array.count)
            weekdayChartData.append(.init(date: firstValue.date, value: avgWeightDiff))
        }
                
        return weekdayChartData
    }
}
