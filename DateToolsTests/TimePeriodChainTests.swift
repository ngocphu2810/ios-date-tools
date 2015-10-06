//
//  TimePeriodChainTests.swift
//  DateTools
//
//  Created by Paweł Sękara on 30.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import XCTest
import Nimble
@testable import DateTools

class TimePeriodChainTests: XCTestCase {
    
    var calendar: NSCalendar!
    var startDate: NSDate!
    var monthPeriod: TimePeriod!
    var twoMonthsPeriod: TimePeriod!
    var monthPeriodAfterMonth: TimePeriod!
    var twoMonthsPeriodAfterTwoWeeks: TimePeriod!
    var fourMonthsPeriod: TimePeriod!
    
    var chain: TimePeriodChain!
    
    override func setUp() {
        super.setUp()
        calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        startDate = calendar.dateWithYear(2010, month: 01, day: 01)
        monthPeriod = self.createTimePeriodWithMothSize(1, startingAt: startDate)
        twoMonthsPeriod = self.createTimePeriodWithMothSize(2, startingAt: startDate)
        monthPeriodAfterMonth = self.createTimePeriodWithMothSize(1, startingAt: calendar.dateByAddingMonths(1, toDate: self.startDate))
        twoMonthsPeriodAfterTwoWeeks = self.createTimePeriodWithMothSize(2, startingAt: calendar.dateByAddingWeeks(2, toDate: self.startDate))
        fourMonthsPeriod = self.createTimePeriodWithMothSize(4, startingAt: self.startDate)
        
        chain = TimePeriodChain(calendar: calendar)
        
        chain.addTimePeriod(monthPeriod)
        chain.addTimePeriod(twoMonthsPeriod)
        chain.addTimePeriod(monthPeriodAfterMonth)
        chain.addTimePeriod(twoMonthsPeriodAfterTwoWeeks)
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testTimePeriodChain_appendElements_createsAChainOfTimePeriods() {
        expect(self.chain[0].startDate) == startDate
        expect(self.chain[0].endDate) == calendar.dateWithYear(2010, month: 02, day: 01)
        
        expect(self.chain[1].startDate) == calendar.dateWithYear(2010, month: 02, day: 01)
        expect(self.chain[1].endDate) == calendar.dateWithYear(2010, month: 04, day: 01)
        
        expect(self.chain[2].startDate) == calendar.dateWithYear(2010, month: 04, day: 01)
        expect(self.chain[2].endDate) == calendar.dateWithYear(2010, month: 04, day: 29)
        
        expect(self.chain[3].startDate) == calendar.dateWithYear(2010, month: 04, day: 29)
        expect(self.chain[3].endDate) == calendar.dateWithYear(2010, month: 06, day: 27)
    }
    
    func testTimePeriodChain_startDate_returnsStartDateOfTimePeriodChain() {
        expect(self.chain.startDate) == startDate
    }
    
    func testTimePeriodChain_endDate_returnsEndDateOfTimePeriodChain() {
        expect(self.chain.endDate) == calendar.dateWithYear(2010, month: 06, day: 27)
    }
    
    func testTimePeriodChain_durationInDays_returnsNumberOfDaysInChain() {
        expect(self.chain.durationInDays) == 177
    }
    
    func testTimePeriodChain_insertTimePeriodAtTheBeginning_insertsTimePeriodWithCorrectedDates() {
        self.chain.insertTimePeriod(self.fourMonthsPeriod, atIndex: 0)
        
        expect(self.chain.first!.endDate) == startDate
        expect(self.chain.first!.startDate) == calendar.dateWithYear(2009, month: 09, day: 3)
        
        expect(self.chain.last!.endDate) == calendar.dateWithYear(2010, month: 06, day: 27)
    }
    
    func testTimePeriodChain_insertFirstTimePeriod_insertsTimePeriodWithCurrentDates() {
        let chain = TimePeriodChain(calendar: self.calendar)
        chain.insertTimePeriod(self.monthPeriod, atIndex: 0)
        
        expect(chain.count) == 1
        expect(chain.startDate) == self.monthPeriod.startDate
        expect(chain.endDate) == self.monthPeriod.endDate
    }
    
    func testTimePeriodChain_insertTimePeriodInTheMiddle_shiftsPeriodsToTheRightToMatchChain() {
        self.chain.insertTimePeriod(TimePeriod(size: .Day, amount: 1, startingAt: startDate, calendar: calendar), atIndex: 2)
        
        expect(self.chain[0].startDate) == startDate
        expect(self.chain[1].endDate) == calendar.dateWithYear(2010, month: 04, day: 01)
        expect(self.chain[2].endDate) == calendar.dateWithYear(2010, month: 04, day: 02)
        expect(self.chain[3].endDate) == calendar.dateWithYear(2010, month: 04, day: 30)
        expect(self.chain[4].endDate) == calendar.dateWithYear(2010, month: 06, day: 28)
    }
    
    func testTimePeriodChain_insertTimePeriodAtTheEnd_appendsTimePeriodToChainWithCorrectedDates() {
        self.chain.insertTimePeriod(TimePeriod(size: .Day, amount: 1, startingAt: chain[3].endDate, calendar: calendar), atIndex: 4)
        
        expect(self.chain[2].endDate) == calendar.dateWithYear(2010, month: 04, day: 29)
        expect(self.chain[3].endDate) == calendar.dateWithYear(2010, month: 06, day: 27)
        expect(self.chain[4].endDate) == calendar.dateWithYear(2010, month: 06, day: 28)
    }
    
    func testTimePeriodChain_insertTimePeriodBeyondTheBounds_doesNothingAndFailsSilently() {
        self.chain.insertTimePeriod(self.fourMonthsPeriod, atIndex: 10)
        
        expect(self.chain.count) == 4
    }
    
    func testTimePeriodChain_removePeriodBeyondTheBounds_doesNothingAndReturnsNil() {
        let removedPeriod = self.chain.removeTimePeriod(atIndex: 10)
        
        expect(self.chain.count) == 4
        expect(removedPeriod).to(beNil())
    }
    
    func testTimePeriodChain_removeLatestAndEarliesFromEmptyChain_doesNothingAndReturnsNil() {
        let chain = TimePeriodChain()
        
        let earliest = chain.removeEarliestTimePeriod()
        let latest = chain.removeLatestTimePeriod()
        
        expect(earliest).to(beNil())
        expect(latest).to(beNil())
    }
    
    func testTimePeriodChain_removeFirstTimePeriod_removesFirstTimePeriodAndShiftsChainLeft() {
        let removedPeriod = self.chain.removeEarliestTimePeriod()
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == calendar.dateWithYear(2010, month: 05, day: 27)
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriodChain_removeMiddleTimePeriod_removesElementAndShiftTheChainLeft() {
        let removedPeriod = self.chain.removeTimePeriod(atIndex: 2)
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == calendar.dateWithYear(2010, month: 05, day: 30)
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriod_removeLastTimePeriod_removesLastElementAndDoesNotShift() {
        let removedPeriod = self.chain.removeLatestTimePeriod()
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == calendar.dateWithYear(2010, month: 04, day: 29)
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriod_isEqualToCopy_returnsTrue() {
        let copy = self.chain.copy() as! TimePeriodChain
        
        expect(self.chain.isEqualToChain(copy)) == true
        expect(self.chain == copy) == true
    }
    
    func testTimePeriod_isEqualToChainWithMorePeriods_returnsFalse() {
        let copy = self.chain.copy() as! TimePeriodChain
        copy.addTimePeriod(self.fourMonthsPeriod)
        
        expect(self.chain.isEqualToChain(copy)) == false
        expect(self.chain == copy) == false
    }
    
    func testTimePeriod_isEqualToChainWithSimilarCharacteristicsButDifferentPeriods_returnsFalse() {
        let chain = TimePeriodChain(calendar: self.calendar)
        chain.addTimePeriod(self.monthPeriod)
        self.twoMonthsPeriod.shortenWithAnchorDate(.Start, size: .Day)
        chain.addTimePeriod(self.twoMonthsPeriod)
        self.monthPeriodAfterMonth.lengthenWithAnchorDate(.Start, size: .Day)
        chain.addTimePeriod(monthPeriodAfterMonth)
        chain.addTimePeriod(twoMonthsPeriodAfterTwoWeeks)
        
        expect(self.chain.isEqualToChain(chain)) == false
        expect(self.chain == chain) == false
        
    }
    
    //MARK: - helpers
    
    func createTimePeriodWithMothSize(amount: Int, startingAt: NSDate) -> TimePeriod {
        return TimePeriod(size: .Month, amount: amount, startingAt: startingAt, calendar: self.calendar)
    }
}
