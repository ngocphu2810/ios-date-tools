//
//  TimePeriodTests.swift
//  DateTools
//
//  Created by Paweł Sękara on 22.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import DateTools

class TimePeriodTests: XCTestCase {
    
    var startDate: NSDate!
    var endDate: NSDate!
    var longPeriod: TimePeriod!
    var shortPeriod: TimePeriod!
    var veryShortPeriod: TimePeriod!
    var periodBefore: TimePeriod!
    var periodAfter: TimePeriod!
    var periodBeforeOverlaps: TimePeriod!
    var periodAfterOverlaps: TimePeriod!
    var periodInside: TimePeriod!
    var periodBeforeTouching: TimePeriod!
    var periodAfterTouching: TimePeriod!

    
    var calendar: NSCalendar!
    
    override func setUp() {
        super.setUp()
        calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        startDate = calendar.dateWithYear(2000, month: 01, day: 01)
        endDate = calendar.dateWithYear(1900, month: 06, day: 15)
        longPeriod = TimePeriod(startDate: endDate, endDate: startDate, calendar: calendar)
        shortPeriod = TimePeriod(startDate: startDate, endDate: calendar.dateWithYear(2000, month: 03, day: 14), calendar: calendar)
        veryShortPeriod = TimePeriod(startDate: startDate, endDate: calendar.dateWithYear(2000, month: 01, day: 02, hour: 12, minute: 20, second: 30), calendar: calendar)
        periodBeforeOverlaps = TimePeriod(startDate: calendar.dateWithYear(1890, month: 01, day: 01), endDate: calendar.dateWithYear(1960, month: 01, day: 01), calendar: calendar)
        periodAfterOverlaps = TimePeriod(startDate: calendar.dateWithYear(1950, month: 01, day: 01), endDate: calendar.dateWithYear(2010, month: 01, day: 01), calendar: calendar)
        periodBefore = TimePeriod(startDate: calendar.dateWithYear(1890, month: 01, day: 01), endDate: calendar.dateWithYear(1900, month: 06, day: 14), calendar: calendar)
        periodAfter = TimePeriod(startDate: calendar.dateWithYear(2000, month: 01, day: 02), endDate: calendar.dateWithYear(2010, month: 01, day: 01), calendar: calendar)
        periodInside = TimePeriod(startDate: calendar.dateWithYear(1950, month: 01, day: 01), endDate: calendar.dateWithYear(1960, month: 01, day: 01), calendar: calendar)
        periodBeforeTouching = TimePeriod(startDate: calendar.dateWithYear(1890, month: 01, day: 01), endDate: calendar.dateWithYear(1900, month: 06, day: 15), calendar: calendar)
        periodAfterTouching = TimePeriod(startDate: calendar.dateWithYear(2000, month: 01, day: 01), endDate: calendar.dateWithYear(2010, month: 01, day: 01), calendar: calendar)

    }
    
    override func tearDown() {
        startDate = nil
        endDate = nil
        longPeriod = nil
        shortPeriod = nil
        veryShortPeriod = nil
        periodBefore = nil
        periodAfter = nil
        periodBeforeOverlaps = nil
        periodAfterOverlaps = nil
        periodInside = nil
        calendar = nil
        periodBeforeTouching = nil
        periodAfterTouching = nil
        super.tearDown()
    }
    
    //MARK: - create with starting date
    
    func testTimePeriod_createPeriodStartingWithDaySize_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Day, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == calendar.dateWithYear(2000, month: 01, day: 02)
    }
    
    func testTimePeriod_createPeriodStartingWithMonthSize_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Month, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == calendar.dateWithYear(2000, month: 02, day: 01)
    }
    
    func testTimePeriod_createPeriodStartingWithYearSize_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Year, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == calendar.dateWithYear(2001, month: 01, day: 01)
    }
    
    func testTimePeriod_createPeriodStartingWithDaySizeAndCustomAmount_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Day, amount: 5, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == calendar.dateWithYear(2000, month: 01, day: 06)
    }
    
    func testTimePeriod_createPeriodStartingWithMonthSizeAndCustomAmount_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Month, amount: 5, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == calendar.dateWithYear(2000, month: 06, day: 01)
    }
    
    func testTimePeriod_createPeriodStartingWithYearSizeAndCustomAmount_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Year, amount: 5, startingAt: startDate, calendar: calendar)
        
        expect(period.startDate) == startDate
        expect(period.endDate) == calendar.dateWithYear(2005, month: 01, day: 01)
    }
    
    //MARK: - create with ending date
    
    func testTimePeriod_createPeriodEndingWithDaySize_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Day, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == calendar.dateWithYear(1900, month: 06, day: 14)
        expect(period.endDate) == endDate
    }
    
    func testTimePeriod_createPeriodEndingWithMonthSize_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Month, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == calendar.dateWithYear(1900, month: 05, day: 15)
        expect(period.endDate) == endDate
    }
    
    func testTimePeriod_createPeriodEndingWithYearSize_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Year, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == calendar.dateWithYear(1899, month: 06, day: 15)
        expect(period.endDate) == endDate
    }
    
    func testTimePeriod_createPeriodEndingWithDaySizeAndCustomAmount_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Day, amount: 5, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == calendar.dateWithYear(1900, month: 06, day: 10)
        expect(period.endDate) == endDate
    }
    
    func testTimePeriod_createPeriodEndingWithMonthSizeAndCustomAmount_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Month, amount: 5, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == calendar.dateWithYear(1900, month: 01, day: 15)
        expect(period.endDate) == endDate
    }
    
    func testTimePeriod_createPeriodEndingWithYearSizeAndCustomAmount_returnsValidTimePeriod() {
        let period = TimePeriod(size: .Year, amount: 5, endingAt: endDate, calendar: calendar)
        
        expect(period.startDate) == calendar.dateWithYear(1895, month: 06, day: 15)
        expect(period.endDate) == endDate
    }
    
    func testTimePeriod_createPeriodWithAllTime_returnsPeriodWithDistantPastAndFuture() {
        let period = TimePeriod.timePeriodWithAllTime()
        expect(period.startDate) == NSDate.distantPast()
        expect(period.endDate) == NSDate.distantFuture()
    }
    
    func testTimePeriod_copyPeriod_returnsCopiedPeriodWithSameDateRange() {
        let period = self.longPeriod.copy() as! TimePeriod
        expect(period.startDate) == self.longPeriod.startDate
        expect(period.endDate) == self.longPeriod.endDate
        expect(period.calendar) == self.longPeriod.calendar
    }
    
    //MARK: - Duration in ... tests
    
    func testTimePeriod_durationInYears_returnsValidAmountOfYearsInPeriod() {
        expect(self.longPeriod.durationIn(.Year)) == 99
        expect(self.shortPeriod.durationIn(.Year)) == 0
        expect(self.veryShortPeriod.durationIn(.Year)) == 0
    }
    
    func testTimePeriod_durationInMonths_returnsValidAmountOfMonhtsInPeriod() {
        expect(self.longPeriod.durationIn(.Month)) == 1194
        expect(self.shortPeriod.durationIn(.Month)) == 2
        expect(self.veryShortPeriod.durationIn(.Month)) == 0
    }
    
    func testTimePeriod_durationInWeeks_returnsValidAmountOfWeeksInPeriod() {
        expect(self.longPeriod.durationIn(.Week)) == 5194
        expect(self.shortPeriod.durationIn(.Week)) == 10
        expect(self.veryShortPeriod.durationIn(.Week)) == 0
    }

    func testTimePeriod_durationInDays_returnsValidAmountOfDaysInPeriod() {
        expect(self.longPeriod.durationIn(.Day)) == 36359
        expect(self.shortPeriod.durationIn(.Day)) == 73
        expect(self.veryShortPeriod.durationIn(.Day)) == 1
    }
    
    func testTimePeriod_durationInHours_returnsValidAmountOfHoursInPeriod() {
        expect(self.veryShortPeriod.durationIn(.Hour)) == 36
    }
    
    func testTimePeriod_durationInMinutes_returnsValidAmountOfMinutesInPeriod() {
        expect(self.veryShortPeriod.durationIn(.Minute)) == 2180
    }
    
    func testTimePeriod_durationInSeconds_returnsValidAmountOfSecondsInPeriod() {
        expect(self.veryShortPeriod.durationIn(.Second)) == 130830
    }
    
    //MARK: - Period comparison tests
    
    func testTimePeriod_isMoment_returnsTrueIfStartDateIsEqualEndDate() {
        let period = TimePeriod(startDate: calendar.dateWithYear(2000), endDate: calendar.dateWithYear(2000), calendar: calendar)
        expect(period.isMoment()) == true
        expect(self.longPeriod.isMoment()) == false
    }
    
    func testTimePeriod_isEqualToPeriod_returnsFalseForDifferentTimePeriods() {
        expect(self.veryShortPeriod.isEqualToPeriod(self.shortPeriod)) == false
        expect(self.veryShortPeriod == self.shortPeriod) == false
    }
    
    func testTimePeriod_isEqualToPeriod_returnsTrueForSameTimePeriods() {
        expect(self.longPeriod.isEqualToPeriod(TimePeriod(startDate: self.endDate, endDate: self.startDate, calendar: self.calendar))) == true
        expect(self.longPeriod == TimePeriod(startDate: self.endDate, endDate: self.startDate, calendar: self.calendar)) == true
    }
    
    func testTimePeriod_isInside_returnsFalseForTimePeriodThatIsNotInsideOfAnotherTimePeriod() {
        expect(self.periodBeforeOverlaps.isInside(self.longPeriod)) == false
        expect(self.periodAfterOverlaps.isInside(self.longPeriod)) == false
    }
    
    func testTimePeriod_isInside_returnsTrueForTimePeriodInsideOrEqual() {
        expect(self.periodInside.isInside(self.longPeriod)) == true
        expect(self.longPeriod.isInside(self.longPeriod)) == true
        expect(self.shortPeriod.isInside(self.shortPeriod)) == true
        expect(self.veryShortPeriod.isInside(self.veryShortPeriod)) == true
    }
    
    func testTimePeriod_contains_returnsFalseForTimePeriodNotContainingOther() {
        expect(self.longPeriod.contains(self.periodBeforeOverlaps)) == false
        expect(self.longPeriod.contains(self.periodAfterOverlaps)) == false
    }
    
    func testTimePeriod_contains_returnsTrueForTimePeriodContainingOther() {
        expect(self.longPeriod.contains(self.periodInside)) == true
        expect(self.longPeriod.contains(self.longPeriod)) == true
        expect(self.shortPeriod.contains(self.shortPeriod)) == true
        expect(self.veryShortPeriod.contains(self.veryShortPeriod)) == true
    }
    
    func testTimePeriod_overlapsWith_returnsTrueIfPeriodsOverlapEachother() {
        expect(self.periodBeforeOverlaps.overlapsWith(self.longPeriod)) == true
        expect(self.periodAfterOverlaps.overlapsWith(self.longPeriod)) == true
        expect(self.periodInside.overlapsWith(self.longPeriod)) == true
        
        expect(self.longPeriod.overlapsWith(self.periodBeforeOverlaps)) == true
        expect(self.longPeriod.overlapsWith(self.periodAfterOverlaps)) == true
        expect(self.longPeriod.overlapsWith(self.periodInside)) == true
    }
    
    func testTimePeriod_overlapsWith_returnsFalseIfPeriodsDoesNotOverlap() {
        expect(self.periodBefore.overlapsWith(self.longPeriod)) == false
        expect(self.periodAfter.overlapsWith(self.longPeriod)) == false
        expect(self.periodBeforeTouching.overlapsWith(self.longPeriod)) == false
        expect(self.periodAfterTouching.overlapsWith(self.longPeriod)) == false
        
        expect(self.longPeriod.overlapsWith(self.periodAfter)) == false
        expect(self.longPeriod.overlapsWith(self.periodBefore)) == false
    }
    
    func testTimePeriod_intersects_returnsFalseIfPeriodsDoesNotIntersect() {
        expect(self.periodBefore.intersects(self.longPeriod)) == false
        expect(self.periodAfter.intersects(self.longPeriod)) == false
        
        expect(self.longPeriod.intersects(self.periodAfter)) == false
        expect(self.longPeriod.intersects(self.periodBefore)) == false
    }
    
    func testTimePeriod_intersects_returnsTrueIfPeriodsIntersect() {
        expect(self.periodBeforeOverlaps.intersects(self.longPeriod)) == true
        expect(self.periodAfterOverlaps.intersects(self.longPeriod)) == true
        expect(self.periodInside.intersects(self.longPeriod)) == true
        expect(self.periodBeforeTouching.intersects(self.longPeriod)) == true
        expect(self.periodAfterTouching.intersects(self.longPeriod)) == true
        
        expect(self.longPeriod.intersects(self.periodBeforeOverlaps)) == true
        expect(self.longPeriod.intersects(self.periodAfterOverlaps)) == true
        expect(self.longPeriod.intersects(self.periodInside)) == true
    }
    
    //MARK: - other utility methods tests
    
    func testTimePeriod_gapBetween_returnsGapInSecondsBetweenTwoTimePeriods() {
        expect(self.longPeriod.gapBetween(self.periodInside)) == 0
        expect(self.longPeriod.gapBetween(self.periodAfter)) == Double(SECONDS_IN_DAY)
        expect(self.longPeriod.gapBetween(self.periodBefore)) == Double(SECONDS_IN_DAY)
    }
    
    func testTimePeriod_containsDate_returnsTrueIfPeriodContainsDate() {
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(1950), interval: TimePeriodInterval.Open)) == true
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(2000), interval: TimePeriodInterval.Open)) == false
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(2050), interval: TimePeriodInterval.Open)) == false
        expect(self.longPeriod.containsDate(self.calendar.dateWithYear(2000), interval: TimePeriodInterval.Closed)) == true
    }
    
    func testCalendarExtension_isLeapYear_returnsWhetherYearIsLeap() {
        expect(NSCalendar.isLeapYear(2000)) == true
        expect(NSCalendar.isLeapYear(2001)) == false
        expect(NSCalendar.isLeapYear(2100)) == false
        expect(NSCalendar.isLeapYear(2004)) == true
    }
    
    
    
    
}

