//
//  WeightBarChart.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/15/24.
//

import SwiftUI
import Charts

struct WeightDiffBarChart: View {
    
    @State var rawSelectedDate: Date?
    @State var selectedDay: Date?
    
    var chartData: [DateValueChartData]
    
    var selectedData: DateValueChartData? {
        ChartHelper.parseSelectedData(from: chartData, in: rawSelectedDate)
    }
    
    var body: some View {
        let config = ChartContainerConfiguration(
            title: "Average Weight Change",
            symbol: "figure",
            subtitle: "Per Weekday (Last 28 days)",
            context: .weight,
            isNav: false
        )
        
        ChartContainer(config: config) {
            if chartData.isEmpty {
                ChartEmptyView(systemImageName: "chart.bar", title: "No Data", description: "There is no weight data from the Health App.")
            } else {
                Chart {
                    if let selectedData {
                        ChartAnnotationView(data: selectedData, context: .weight)
                    }
                    
                    ForEach(chartData) { weekdayDiff in
                        BarMark(
                            x: .value("Date", weekdayDiff.date, unit: .day),
                            y: .value("Weight Diff", weekdayDiff.value)
                        )
                        .foregroundStyle(weekdayDiff.value >= 0 ? Color.indigo.gradient : Color.mint.gradient)
                    }
                }
                .frame(height: 150)
                .chartXSelection(value: $rawSelectedDate.animation(.easeInOut))
                .chartXAxis {
                    AxisMarks(values: .stride(by: .day)) {
                        AxisValueLabel(format: .dateTime.weekday(), centered: true)
                    }
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisGridLine()
                            .foregroundStyle(Color.secondary.opacity(0.3))
                        
                        AxisValueLabel()
                    }
                }
            }
        }
        .sensoryFeedback(.selection, trigger: selectedDay)
        .onChange(of: rawSelectedDate) { oldValue, newValue in
            if oldValue?.weekdayInt != newValue?.weekdayInt {
                selectedDay = newValue
            }
        }
    }
}

#Preview {
    WeightDiffBarChart(chartData: MockData.weightDiffs)
}
