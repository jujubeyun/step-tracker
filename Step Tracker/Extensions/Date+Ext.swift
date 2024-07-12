//
//  Date+Ext.swift
//  Step Tracker
//
//  Created by Juhyun Yun on 7/12/24.
//

import Foundation

extension Date {
    var weekdayInt: Int {
        Calendar.current.component(.weekday, from: self)
    }
    
    var weekdayTitle: String {
        self.formatted(.dateTime.weekday(.wide))
    }
}
