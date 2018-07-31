//
//  DateHelper.swift
//  Routines
//
//  Created by André Martingo on 26/07/2018.
//  Copyright © 2018 André Martingo. All rights reserved.
//

import Foundation

class DateHelper {
    static func convertDateToString(date: Date) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatterGet.string(from: date)
    }
}
