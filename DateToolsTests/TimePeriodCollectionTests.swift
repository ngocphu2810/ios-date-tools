//
//  TimePeriodCollectionTests.swift
//  DateTools
//
//  Created by Paweł Sękara on 29.09.2015.
//  Copyright © 2015 CodeWise sp. z o.o. Sp. k. All rights reserved.
//

import XCTest
import Nimble
@testable import DateTools

class TimePeriodCollectionTests: XCTestCase {
    
    var collection: TimePeriodCollection!
    var emptyCollection: TimePeriodCollection!
    var calendar: NSCalendar!
    var startDate: NSDate!
    
    var monthPeriod: TimePeriod!
    var twoMonthsPeriod: TimePeriod!
    var monthPeriodAfterMonth: TimePeriod!
    var twoMonthsPeriodAfterTwoWeeks: TimePeriod!
    
    var fourMonthsPeriod: TimePeriod!
    
    override func setUp() {
        super.setUp()
        calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        calendar.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        collection = TimePeriodCollection(calendar: calendar)
        emptyCollection = TimePeriodCollection(calendar: calendar)
        
        startDate = date("2010-01-01")
        monthPeriod = self.createTimePeriodWithMonthSize(1, startingAt: startDate)
        twoMonthsPeriod = self.createTimePeriodWithMonthSize(2, startingAt: startDate)
        monthPeriodAfterMonth = self.createTimePeriodWithMonthSize(1, startingAt: calendar.dateByAddingMonths(1, toDate: self.startDate))
        twoMonthsPeriodAfterTwoWeeks = self.createTimePeriodWithMonthSize(2, startingAt: calendar.dateByAddingWeeks(2, toDate: self.startDate))
        fourMonthsPeriod = self.createTimePeriodWithMonthSize(4, startingAt: self.startDate)
        
        collection.addTimePeriod(monthPeriod)
        collection.addTimePeriod(twoMonthsPeriod)
        collection.addTimePeriod(monthPeriodAfterMonth)
        collection.addTimePeriod(twoMonthsPeriodAfterTwoWeeks)
    }
    
    override func tearDown() {
        collection = nil
        calendar = nil
        startDate = nil
        super.tearDown()
    }
    
    func testPeriodCollection_getSubscript_returnsPeriodAtGivenSubscript() {
        expect(self.collection[0]) == monthPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == monthPeriodAfterMonth
        expect(self.collection[3]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_setSubscript_setsTimePeriodAtGivenSubscript() {
        self.collection[0] = fourMonthsPeriod
        self.collection[3] = monthPeriod
        
        expect(self.collection[0]) == fourMonthsPeriod
        expect(self.collection[3]) == monthPeriod
    }
    
    func testPeriodCollection_count_returnsCountOfPeriodsInCollection() {
        expect(self.collection.count) == 4
    }
    
    func testPeriodCollection_startDate_returnsTheEarliestStartDateFromCollection() {
        expect(self.collection.startDate) == self.startDate
    }
    
    func testPeriodCollection_endDate_returnsTheOldestDateFromCollection() {
        expect(self.collection.endDate) == self.twoMonthsPeriodAfterTwoWeeks.endDate
    }
    
    //MARK: - Duration in ... tests
    
    func testPeriodCollection_durationInYears_returnsOverallDurationOfAllPeriodsInYears() {
        expect(self.collection.durationInYears) == 0
    }
    
    func testPeriodCollection_durationInMonths_returnsOverallDurationOfAllPeriodsInMonths() {
        expect(self.collection.durationInMonths) == 2
    }
    
    func testPeriodCollection_durationInWeeks_returnsOverallDurationOfAllPeriodsInWeeks() {
        expect(self.collection.durationInWeeks) == 10
    }
    
    func testPeriodCollection_durationInDays_returnsOverallDurationOfAllPeriodsInDays() {
        expect(self.collection.durationInDays) == 73
    }
    
    func testPeriodCollection_durationInHours_returnsOverallDurationOfAllPeriodsInHours() {
        expect(self.collection.durationInHours) == 73 * 24
    }
    
    func testPeriodCollection_durationInMinutes_returnsOverallDurationOfAllPeriodsInMinutes() {
        expect(self.collection.durationInMinutes) == 73 * 24 * 60
    }
    
    func testPeriodCollection_durationInSeconds_returnsOverallDurationOfAllPeriodsInSeconds() {
        expect(self.collection.durationInSeconds) == 73 * 24 * 60 * 60
    }
    
    func testPeriodCollection_durationForEmptyCollection_returnsZero() {
        expect(self.emptyCollection.durationInSeconds) == 0
        expect(self.emptyCollection.durationInMinutes) == 0
        expect(self.emptyCollection.durationInHours)   == 0
        expect(self.emptyCollection.durationInDays)    == 0
        expect(self.emptyCollection.durationInWeeks)   == 0
        expect(self.emptyCollection.durationInMonths)  == 0
        expect(self.emptyCollection.durationInYears)   == 0
    }
    
    //MARK: - Adding periods
    
    func testPeriodCollection_addTimePeriod_addsTimePeriodAtTheEndOfCollection() {
        collection.addTimePeriod(fourMonthsPeriod)
        expect(self.collection[4]) == fourMonthsPeriod
        expect(self.collection.count) == 5
    }
    
    func testPeriodCollection_insertTimePeriodAtTheBeginning_insertsTimePeriodAtTheBeginning() {
        collection.insertTimePeriod(fourMonthsPeriod, atIndex: 0)
        expect(self.collection[0]) == fourMonthsPeriod
        expect(self.collection[1]) == monthPeriod
        expect(self.collection.count) == 5
    }
    
    func testPeriodCollection_insertTimePeriodInTheMiddle_insertsTimePeriodInTheMiddle() {
        collection.insertTimePeriod(fourMonthsPeriod, atIndex: 2)
        expect(self.collection[2]) == fourMonthsPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[3]) == monthPeriodAfterMonth
        expect(self.collection.count) == 5
    }
    
    func testPeriodCollection_insertAtTheEnd_insertsTimePeriodAtTheEnd() {
        collection.insertTimePeriod(fourMonthsPeriod, atIndex: 4)
        expect(self.collection[4]) == fourMonthsPeriod
    }
    
    func testPeriodCollection_insertAtBadIndex_doesNotInsertTimePeriod() {
        collection.insertTimePeriod(fourMonthsPeriod, atIndex: 5)
        expect(self.collection.count) == 4
    }
    
    //MARK: - Removing periods
    
    func testPeriodCollection_removeFirstTimePeriod_removesAndReturnFirstTimePeriod() {
        let removedPeriod = self.collection.removeTimePeriod(atIndex: 0)
        expect(removedPeriod) == monthPeriod
        expect(self.collection.count) == 3
        expect(self.collection[0]) == twoMonthsPeriod
    }
    
    func testPeriodCollection_removeMiddleTimePeriod_removesMiddleTimePeriodAndReturn() {
        let removedPeriod = self.collection.removeTimePeriod(atIndex: 2)
        expect(removedPeriod) == monthPeriodAfterMonth
        expect(self.collection[2]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection.count) == 3
    }
    
    func testPeriodCollection_removeLastTimePeriod_removesLastTimePeriodAndReturn() {
        let removedPeriod = self.collection.removeTimePeriod(atIndex: 3)
        expect(removedPeriod) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection.count) == 3
    }
    
    func testPeriodCollection_removePeriodOutsideBounds_doesNotCrashAndReturnsNil() {
        let removedPeriod = self.collection.removeTimePeriod(atIndex: 4)
        expect(removedPeriod).to(beNil())
        expect(self.collection.count) == 4
    }
    
    func testPeriodCollection_removeAllPeriodsFromCollection_yieldsEmptyCollection() {
        self.collection.removeTimePeriod(atIndex: 0)
        self.collection.removeTimePeriod(atIndex: 0)
        self.collection.removeTimePeriod(atIndex: 0)
        self.collection.removeTimePeriod(atIndex: 0)
        
        expect(self.collection.count) == 0
    }
    
    //MARK: - Sorting
    
    func testPeriodCollection_sortingByStartAscending_sortsPeriodsByStartAscending() {
        collection.sortByStartAscending()
        expect(self.collection[0]) == monthPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[3]) == monthPeriodAfterMonth
    }
    
    func testPeriodCollection_sortByStartDescending_sortsPeriodsByStartDescending() {
        collection.sortByStartDescending()
        expect(self.collection[0]) == monthPeriodAfterMonth
        expect(self.collection[1]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[2]) == monthPeriod
        expect(self.collection[3]) == twoMonthsPeriod
    }
    
    func testPeriodCollection_sortByEndAscending_sortsPeriodsByEndAscending() {
        collection.sortByEndAscending()
        expect(self.collection[0]) == monthPeriod
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == monthPeriodAfterMonth
        expect(self.collection[3]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_sortByEndDescending_sortsPeriodsByEndDescending() {
        collection.sortByEndDescending()
        expect(self.collection[0]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[1]) == twoMonthsPeriod
        expect(self.collection[2]) == monthPeriodAfterMonth
        expect(self.collection[3]) == monthPeriod
    }
    
    func testPeriodCollection_sortByDurationAscending_sortsPeriodsByDurationAscending() {
        collection.sortByDurationAscending()
        expect(self.collection[0]) == monthPeriodAfterMonth
        expect(self.collection[1]) == monthPeriod
        expect(self.collection[2]) == twoMonthsPeriod
        expect(self.collection[3]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_sortByDurationDescending_sortsPeriodsByDurationDescending() {
        collection.sortByDurationDescending()
        expect(self.collection[0]) == twoMonthsPeriod
        expect(self.collection[1]) == twoMonthsPeriodAfterTwoWeeks
        expect(self.collection[2]) == monthPeriod
        expect(self.collection[3]) == monthPeriodAfterMonth
    }
    
    //MARK: - shifting tests
    
    func testPeriodCollection_shiftLater_shiftsAllPeriodsLaterByGivenSize() {
        collection.shiftLaterWithSize(.Week, amount: 1)
        
        expect(self.collection[0].startDate) == date("2010-01-08")
        expect(self.collection[0].endDate)   == date("2010-02-08")
        
        expect(self.collection[1].startDate) == date("2010-01-08")
        expect(self.collection[1].endDate)   == date("2010-03-08")
        
        expect(self.collection[2].startDate) == date("2010-02-08")
        expect(self.collection[2].endDate)   == date("2010-03-08")
        
        expect(self.collection[3].startDate) == date("2010-01-22")
        expect(self.collection[3].endDate)   == date("2010-03-22")
    }
    
    func testPeriodCollection_shiftEarlier_shiftsAllPeriodsEarlierByGivenSize() {
        collection.shiftEarlierWithSize(.Month, amount: 2)
        
        expect(self.collection[0].startDate) == date("2009-11-01")
        expect(self.collection[0].endDate)   == date("2009-12-01")
        
        expect(self.collection[1].startDate) == date("2009-11-01")
        expect(self.collection[1].endDate)   == date("2010-01-01")
        
        expect(self.collection[2].startDate) == date("2009-12-01")
        expect(self.collection[2].endDate)   == date("2010-01-01")
        
        expect(self.collection[3].startDate) == date("2009-11-15")
        expect(self.collection[3].endDate)   == date("2010-01-15")
    }
    
    func testPeriodCollection_isEqualToCollectionConsideringOrder_returnsTrueWhenCollectionsAreEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        let secondCollection = TimePeriodCollection(calendar: calendar)
        secondCollection.addTimePeriod(monthPeriod)
        secondCollection.addTimePeriod(twoMonthsPeriod)
        secondCollection.addTimePeriod(monthPeriodAfterMonth)
        secondCollection.addTimePeriod(twoMonthsPeriodAfterTwoWeeks)
        
        expect(collectionCopy.isEqualToCollection(self.collection, considerOrder: true)) == true
        expect(secondCollection.isEqualToCollection(self.collection, considerOrder: true)) == true
        expect(TimePeriodCollection().isEqualToCollection(self.emptyCollection, considerOrder: true)) == true
    }
    
    func testPeriodCollection_isEqualToCollectionWithDifferentCharacteristics_returnsFalse() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy[1] = fourMonthsPeriod
        
        expect(collectionCopy.isEqualToCollection(self.collection)) == false
    }
    
    func testPeriodCollection_isEqualToCollectionConsideringOrder_returnsFalseWhenCollectionsAreNotEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy.addTimePeriod(fourMonthsPeriod)
        let collection2 = self.collection.copy() as! TimePeriodCollection
        collection2[0] = collection[1]
        collection2[1] = collection[0]
        
        expect(collectionCopy.isEqualToCollection(self.collection, considerOrder: true)) == false
        expect(collection2.isEqualToCollection(self.collection, considerOrder: true)) == false
    }
    
    func testPeriodCollection_isEqualNotConsideringOrder_returnsTrueWhenCollectionsAreEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy[0] = collection[1]
        collectionCopy[1] = collection[0]
        
        expect(collectionCopy.isEqualToCollection(self.collection)) == true
    }
    
    func testPeriodCollection_isEqualNotConsideringOrder_returnsFalseWhenCollectionsAreNotEqual() {
        let collectionCopy = self.collection.copy() as! TimePeriodCollection
        collectionCopy[0] = TimePeriod(size: .Week, amount: 2, startingAt: self.startDate, calendar: self.calendar)
        
        expect(collectionCopy.isEqualToCollection(self.collection)) == false
        expect(collectionCopy == self.collection) == false

    }
    
    //MARK: - period relationship methods
    
    func testPeriodCollection_periodsInside_returnsAllPeriodsInsideOfAGivenPeriod() {
        let periods1 = self.collection.periodsInside(TimePeriod(size: .Week, amount: 5, startingAt: self.startDate, calendar: self.calendar))
        let periods2 = self.collection.periodsInside(TimePeriod(size: .Month, amount: 2, endingAt: self.twoMonthsPeriodAfterTwoWeeks.endDate, calendar: self.calendar))
        
        expect(periods1.count) == 1
        expect(periods1[0]) == monthPeriod
        
        expect(periods2.count) == 2
        expect(periods2[0]) == monthPeriodAfterMonth
        expect(periods2[1]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_periodsIntersectedByDate_returnsAllPeriodsThatContainGivenDate() {
        let periods1 = self.collection.periodsIntersectedByDate(date("2010-01-20"))
        let periods2 = self.collection.periodsIntersectedByDate(date("2010-03-02"))
        
        expect(periods1.count) == 3
        expect(periods1.periods).to(contain(monthPeriod, twoMonthsPeriod, twoMonthsPeriodAfterTwoWeeks))
        
        expect(periods2.count) == 1
        expect(periods2[0]) == twoMonthsPeriodAfterTwoWeeks
    }
    
    func testPeriodCollection_periodsIntersectedByPeriod_returnsAllPeriodsThatIntersectWithGivenPeriod() {
        let periods1 = self.collection.periodsIntersectedByPeriod(TimePeriod(size: .Week, amount: 5, startingAt: self.startDate.dateBySubtractingDays(5), calendar: self.calendar))
        let periods2 = self.collection.periodsIntersectedByPeriod(TimePeriod(size: .Week, amount: 1, startingAt: self.twoMonthsPeriod.endDate, calendar: self.calendar))
        
        expect(periods1.count) == 3
        expect(periods1.periods).to(contain(monthPeriod, twoMonthsPeriod, twoMonthsPeriodAfterTwoWeeks))
        
        expect(periods2.count) == 3
        expect(periods2.periods).to(contain(twoMonthsPeriod, monthPeriodAfterMonth, twoMonthsPeriodAfterTwoWeeks))
    }
    
    func testPeriodCollection_periodsOverlappedByPeriod_returnsAllPeriodsOverlappedByGivenPeriod() {
        let periods1 = self.collection.periodsOverlappedByPeriod(TimePeriod(size: .Month, amount: 2, startingAt: self.startDate.dateBySubtractingMonths(1), calendar: self.calendar))
        let periods2 = self.collection.periodsOverlappedByPeriod(TimePeriod(size: .Week, amount: 1, startingAt: self.twoMonthsPeriod.endDate, calendar: self.calendar))
        
        expect(periods1.count) == 3
        expect(periods1.periods).to(contain(monthPeriod, twoMonthsPeriod, twoMonthsPeriodAfterTwoWeeks))
        
        expect(periods2.count) == 1
        expect(periods2.periods).to(contain(twoMonthsPeriodAfterTwoWeeks))
    }

    //MARK: - helpers
    
    func createTimePeriodWithMonthSize(amount: Int, startingAt: NSDate) -> TimePeriod {
        return TimePeriod(size: .Month, amount: amount, startingAt: startingAt, calendar: self.calendar)
    }
    
}
