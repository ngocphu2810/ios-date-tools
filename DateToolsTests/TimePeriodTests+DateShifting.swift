//
//  TimePeriodTests+DateShifting.swift
//  DateTools
//
//  Created by Paweł Sękara on 23.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import DateTools

extension TimePeriodTests {
    
    //MARK: - Date shifting methods
    
    //MARK: earlier
    
    func testTimePeriod_shiftEarlierWithSecondSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Second)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 23, minute: 59, second: 59)
    }
    
    func testTimePeriod_shiftEarlierWithMinuteSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Minute)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 23, minute: 59)
    }
    
    func testTimePeriod_shiftEarlierWithHourSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Hour)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 23)
    }
    
    func testTimePeriod_shiftEarlierWithDaySize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Day)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31)
    }
    
    func testTimePeriod_shiftEarlierWithWeekSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Week)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 25)
    }
    
    func testTimePeriod_shiftEarlierWithMonthSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Month)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 01)
    }
    
    func testTimePeriod_shiftEarlierWithYearSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftEarlierWithSize(.Year)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 01, day: 01)
    }
    
    //MARK: later
    
    func testTimePeriod_shiftLaterWithSecondSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Second)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, hour: 00, minute: 00, second: 01)
    }
    
    func testTimePeriod_shiftLaterWithMinuteSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Minute)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, hour: 00, minute: 01)
    }
    
    func testTimePeriod_shiftLaterWithHourSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Hour)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, hour: 01)
    }
    
    func testTimePeriod_shiftLaterWithDaySize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Day)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 02)
    }
    
    func testTimePeriod_shiftLaterWithWeekSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Week)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 08)
    }
    
    func testTimePeriod_shiftLaterWithMonthSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Month)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 02)
    }
    
    func testTimePeriod_shiftLaterWithYearSize_shiftsDateEarlierByGivenPeriodSize() {
        self.shortPeriod.shiftLaterWithSize(.Year)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2001)
    }
    
    //MARK: - lengthen with anchor Start
    
    func testTimePeriod_lengthenWithStartAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Second, amount: 39)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14, hour: 00, minute: 00, second: 39)
    }
    
    func testTimePeriod_lengthenWithStartAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Minute, amount: 41)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14, hour: 00, minute: 41)
    }

    func testTimePeriod_lengthenWithStartAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Hour, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14, hour: 05)
    }
    
    func testTimePeriod_lengthenWithStartAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Day, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 19)
    }
    
    func testTimePeriod_lengthenWithStartAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 28)
    }
    
    func testTimePeriod_lengthenWithStartAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 07, day: 14)
    }
    
    func testTimePeriod_lengthenWithStartAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Start, size: .Year, amount: 7)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2007, month: 03, day: 14)
    }
    
    //MARK: lengthen with anchor Center

    func testTimePeriod_lengthenWithCenterAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 23, minute: 59, second: 40)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14, hour: 00, minute: 00, second: 20)
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour:23, minute:45, second: 00)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14, hour: 00, minute: 15)
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 21)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14, hour: 3)
    }

    func testTimePeriod_lengthenWithCenterAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 30)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 16)
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 25)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 21)
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 11, day: 01)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 05, day: 14)
    }
    
    func testTimePeriod_lengthenWithCenterAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.Center, size: .Year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1996)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2004, month: 03, day: 14)
    }

    //MARK: lengthen with anchor end
    
    func testTimePeriod_lengthenWithEndAnchorBySeconds_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 23, minute: 59, second: 20)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_lengthenWithEndAnchorByMinutes_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 23, minute: 30, second: 00)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_lengthenWithEndAnchorByHours_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 31, hour: 18)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_lengthenWithEndAnchorByDays_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 28)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_lengthenWithEndAnchorByWeeks_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 12, day: 18)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_lengthenWithEndAnchorByMonths_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1999, month: 09, day: 01)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_lengthenWithEndAnchorByYears_lengthensPeriodByGivenSize() {
        self.shortPeriod.lengthenWithAnchorDate(.End, size: .Year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(1992)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    //MARK: - shorten with anchor start
    
    func testTimePeriod_shortenWithStartAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Second, amount: 39)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 13, hour: 23, minute: 59, second: 21)
    }
    
    func testTimePeriod_shortenWithStartAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Minute, amount: 41)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 13, hour: 23, minute: 19)
    }
    
    func testTimePeriod_shortenWithStartAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Hour, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 13, hour: 19)
    }
    
    func testTimePeriod_shortenWithStartAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Day, amount: 5)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 09)
    }
    
    func testTimePeriod_shortenWithStartAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 02, day: 29)
    }
    
    func testTimePeriod_shortenWithStartAnchorByMonths_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(1999, month: 11, day: 14)
    }
    
    func testTimePeriod_shortenWithStartAnchorByYears_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Start, size: .Year, amount: 7)
        expect(self.shortPeriod.startDate) == startDate
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(1993, month: 03, day: 14)
    }
    
    //MARK: shorten with anchor center
    
    func testTimePeriod_shortenWithCenterAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 01, hour: 00, minute: 00, second: 20)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 13, hour: 23, minute: 59, second: 40)
    }
    
    func testTimePeriod_shortenWithCenterAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 01, hour: 00, minute: 15, second: 00)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 13, hour: 23, minute: 45)
    }
    
    func testTimePeriod_shortenWithCenterAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 01, hour: 3)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 13, hour: 21)
    }
    
    func testTimePeriod_shortenWithCenterAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 03)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 12)
    }
    
    func testTimePeriod_shortenWithCenterAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.Center, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 08)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 07)
    }
    
    func testTimePeriod_shortenWithCenterAnchorByMonths_shortensPeriodByGivenSize() {
        self.longPeriod.shortenWithAnchorDate(.Center, size: .Month, amount: 4)
        expect(self.longPeriod.startDate) == calendar.dateWithYear(1900, month: 08, day: 15)
        expect(self.longPeriod.endDate) == calendar.dateWithYear(1999, month: 11, day: 01)
    }
    
    func testTimePeriod_shortenWithCenterAnchorByYears_shortensPeriodByGivenSize() {
        self.longPeriod.shortenWithAnchorDate(.Center, size: .Year, amount: 8)
        expect(self.longPeriod.startDate) == calendar.dateWithYear(1904, month: 06, day: 15)
        expect(self.longPeriod.endDate) == calendar.dateWithYear(1996, month: 01, day: 01)
    }
    
    //MARK: shorten with anchor end
    
    func testTimePeriod_shortenWithEndAnchorBySeconds_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Second, amount: 40)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 01, hour: 00, minute: 00, second: 40)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_shortenWithEndAnchorByMinutes_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Minute, amount: 30)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 01, hour: 00, minute: 30)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_shortenWithEndAnchorByHours_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Hour, amount: 6)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 01, hour: 06)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_shortenWithEndAnchorByDays_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Day, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 05)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_shortenWithEndAnchorByWeeks_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Week, amount: 2)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 01, day: 15)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_shortenWithEndAnchorByMonths_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Month, amount: 4)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2000, month: 05)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    func testTimePeriod_shortenWithEndAnchorByYears_shortensPeriodByGivenSize() {
        self.shortPeriod.shortenWithAnchorDate(.End, size: .Year, amount: 8)
        expect(self.shortPeriod.startDate) == calendar.dateWithYear(2008)
        expect(self.shortPeriod.endDate) == calendar.dateWithYear(2000, month: 03, day: 14)
    }
    
    
}

