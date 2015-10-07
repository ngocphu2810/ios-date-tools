//
//  DateTestUtils.swift
//  DateTools
//
//  Created by Paweł Sękara on 07.10.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import Foundation

let secondPrecisionFormatter = createFormatterWithFormat("yyyy-MM-dd HH:mm:ss")
let minutePrecisionFormatter = createFormatterWithFormat("yyyy-MM-dd HH:mm")
let hourPrecisionFormatter = createFormatterWithFormat("yyyy-MM-dd HH")
let dayPrecisionFormatter = createFormatterWithFormat("yyyy-MM-dd")


func date(dateString: String) -> NSDate {
    for formatter in [secondPrecisionFormatter, minutePrecisionFormatter, hourPrecisionFormatter, dayPrecisionFormatter] {
        if let date = formatter.dateFromString(dateString) {
            return date
        }
    }
    return NSDate(timeIntervalSince1970: 0)
}

private func createFormatterWithFormat(format: String) -> NSDateFormatter {
    let formatter = NSDateFormatter()
    formatter.dateFormat = format
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    return formatter
}