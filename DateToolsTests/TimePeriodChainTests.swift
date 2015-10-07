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
        startDate = date("2010-01-01")
        monthPeriod = self.createTimePeriodWithMonthSize(1, startingAt: startDate)
        twoMonthsPeriod = self.createTimePeriodWithMonthSize(2, startingAt: startDate)
        monthPeriodAfterMonth = self.createTimePeriodWithMonthSize(1, startingAt: calendar.dateByAddingMonths(1, toDate: self.startDate))
        twoMonthsPeriodAfterTwoWeeks = self.createTimePeriodWithMonthSize(2, startingAt: calendar.dateByAddingWeeks(2, toDate: self.startDate))
        fourMonthsPeriod = self.createTimePeriodWithMonthSize(4, startingAt: self.startDate)
        
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
        expect(self.chain[0].endDate)   == date("2010-02-01")
        
        expect(self.chain[1].startDate) == date("2010-02-01")
        expect(self.chain[1].endDate)   == date("2010-04-01")
        
        expect(self.chain[2].startDate) == date("2010-04-01")
        expect(self.chain[2].endDate)   == date("2010-04-29")
        
        expect(self.chain[3].startDate) == date("2010-04-29")
        expect(self.chain[3].endDate)   == date("2010-06-27")
    }
    
    func testTimePeriodChain_startDate_returnsStartDateOfTimePeriodChain() {
        expect(self.chain.startDate) == startDate
    }
    
    func testTimePeriodChain_endDate_returnsEndDateOfTimePeriodChain() {
        expect(self.chain.endDate) == date("2010-06-27")
    }
    
    func testTimePeriodChain_durationInDays_returnsNumberOfDaysInChain() {
        expect(self.chain.durationInDays) == 177
    }
    
    func testTimePeriodChain_insertTimePeriodAtTheBeginning_insertsTimePeriodWithCorrectedDates() {
        self.chain.insertTimePeriod(self.fourMonthsPeriod, atIndex: 0)
        
        expect(self.chain.first!.endDate) == startDate
        expect(self.chain.first!.startDate) == date("2009-09-03")
        
        expect(self.chain.last!.endDate) == date("2010-06-27")
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
        expect(self.chain[1].endDate) == date("2010-04-01")
        expect(self.chain[2].endDate) == date("2010-04-02")
        expect(self.chain[3].endDate) == date("2010-04-30")
        expect(self.chain[4].endDate) == date("2010-06-28")
    }
    
    func testTimePeriodChain_insertTimePeriodAtTheEnd_appendsTimePeriodToChainWithCorrectedDates() {
        self.chain.insertTimePeriod(TimePeriod(size: .Day, amount: 1, startingAt: chain[3].endDate, calendar: calendar), atIndex: 4)
        
        expect(self.chain[2].endDate) == date("2010-04-29")
        expect(self.chain[3].endDate) == date("2010-06-27")
        expect(self.chain[4].endDate) == date("2010-06-28")
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
        expect(self.chain.endDate) == date("2010-05-27")
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriodChain_removeMiddleTimePeriod_removesElementAndShiftTheChainLeft() {
        let removedPeriod = self.chain.removeTimePeriod(atIndex: 2)
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == date("2010-05-30")
        expect(removedPeriod).notTo(beNil())
    }
    
    func testTimePeriod_removeLastTimePeriod_removesLastElementAndDoesNotShift() {
        let removedPeriod = self.chain.removeLatestTimePeriod()
        
        expect(self.chain.count) == 3
        expect(self.chain.startDate) == self.startDate
        expect(self.chain.endDate) == date("2010-04-29")
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
    
    func createTimePeriodWithMonthSize(amount: Int, startingAt: NSDate) -> TimePeriod {
        return TimePeriod(size: .Month, amount: amount, startingAt: startingAt, calendar: self.calendar)
    }
}
