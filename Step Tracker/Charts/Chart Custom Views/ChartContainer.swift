//
//  ChartContainer.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/17/24.
//

import SwiftUI

enum ChartType {
    case stepBar(average: Int)
    case stepWeekdayPie
    case weightLine(average: Double)
    case weightDiffBar
    
    var isNav: Bool {
        switch self {
        case .stepBar, .weightLine:
            return true
        case .stepWeekdayPie, .weightDiffBar:
            return false
        }
    }
    
    var context: HealthMetricContext {
        switch self {
        case .stepBar, .stepWeekdayPie:
            return .steps
        case .weightLine, .weightDiffBar:
            return .weight
        }
    }
    
    var title: String {
        switch self {
        case .stepBar:
            "Steps"
        case .stepWeekdayPie:
            "Averages"
        case .weightLine:
            "Weight"
        case .weightDiffBar:
            "Average Weight Change"
        }
    }
    
    var symbol: String {
        switch self {
        case .stepBar:
            "figure.walk"
        case .stepWeekdayPie:
            "calendar"
        case .weightLine, .weightDiffBar:
            "figure"
        }
    }
    
    var subtitle: String {
        switch self {
        case .stepBar(let average):
            "Avg: \(average.formatted()) Steps"
        case .stepWeekdayPie:
            "Last 28 Days"
        case .weightLine(let average):
            "Avg: \(average.formatted(.number.precision(.fractionLength(1)))) lbs"
        case .weightDiffBar:
            "Per Weekday (Last 28 days)"
        }
    }
}

struct ChartContainer<Content: View>: View {
    
    let chartType: ChartType
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            if chartType.isNav {
                navigationLinkView
            } else {
                titleView
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 12)
            }
            
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
    }
    
    var navigationLinkView: some View {
        NavigationLink(value: chartType.context) {
            HStack {
                titleView
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .foregroundStyle(.secondary)
        .padding(.bottom, 12)
    }
    
    var titleView: some View {
        VStack(alignment: .leading) {
            Label(chartType.title, systemImage: chartType.symbol)
                .font(.title3.bold())
                .foregroundStyle(chartType.context == .steps ? .pink : .indigo)
            
            Text(chartType.subtitle)
                .font(.caption)
        }
    }
}

#Preview {
    ChartContainer(chartType: .stepWeekdayPie) {
        Text("Chart goes here")
            .frame(height: 150)
    }
}