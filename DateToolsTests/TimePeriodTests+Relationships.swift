//
//  TimePeriodTests+Relationships.swift
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
    
    //MARK: - relationship methods
    
    func testTimePeriod_relationToPeriodAfter_returnsAfterPeriodRelation() {
        expect(self.longPeriod.relationToPeriod(self.periodBefore)) == TimePeriodRelation.After
    }
    
    func testTimePeriod_relationToPeriodStartTouching_returnsStartTouchingPeriodRelation() {
        expect(self.periodAfterTouching.relationToPeriod(self.longPeriod)) == TimePeriodRelation.StartTouching
    }
    
    func testTimePeriod_relationToPeriodStartInside_returnsStartInsidePeriodRelation() {
        let startInsidePeriod = TimePeriod(startDate: calendar.dateWithYear(1800), endDate: calendar.dateWithYear(1950), calendar: calendar)
        expect(self.longPeriod.relationToPeriod(startInsidePeriod)) == TimePeriodRelation.StartInside
    }
    
    func testTimePeriod_relationToPeriodInsideStartTouching_returnsInsideStartTouchingPeriodRelation() {
        let insideTouchingPeriod = TimePeriod(startDate: date("1900-06-15"), endDate: date("2020-01-10"), calendar: self.calendar)
        expect(self.longPeriod.relationToPeriod(insideTouchingPeriod)) == TimePeriodRelation.InsideStartTouching
    }
    
    func testTimePeriod_relationToPeriodEnclosingStartTouching_returnsEnclosingStartTouchingPeriodRelation() {
        let enclosingStartTouching = TimePeriod(startDate: date("1900-06-15"), endDate: calendar.dateWithYear(1950), calendar: calendar)
        expect(self.longPeriod.relationToPeriod(enclosingStartTouching)) == TimePeriodRelation.EnclosingStartTouching
    }
    
    func testTimePeriod_relationToPeriodEnclosing_returnsEnclosingPeriodRelation() {
        expect(self.longPeriod.relationToPeriod(self.periodInside)) == TimePeriodRelation.Enclosing
    }
    
    func testTimePeriod_relationToPeriodEnclosingEndTouching_returnsEnclosingEndTouchingRelation() {
        let enclosingEndTouching = TimePeriod(startDate: calendar.dateWithYear(1910), endDate: calendar.dateWithYear(2000), calendar: calendar)
        expect(self.longPeriod.relationToPeriod(enclosingEndTouching)) == TimePeriodRelation.EnclosingEndTouching
    }
    
    func testTimePeriod_relationToPeriodExactMatch_returnsExactMatchRelation() {
        expect(self.longPeriod.relationToPeriod(self.longPeriod)) == TimePeriodRelation.ExactMatch
    }
    
    func testTimePeriod_relationToPeriodInside_returnsInsideRelation() {
        expect(self.periodInside.relationToPeriod(self.longPeriod)) == TimePeriodRelation.Inside
    }
    
    func testTimePeriod_relationToPeriodInsideEndTouching_returnsInsideEndTouchingRelation() {
        let insideEndTouching = TimePeriod(startDate: calendar.dateWithYear(1850), endDate: calendar.dateWithYear(2000), calendar: calendar)
        expect(self.longPeriod.relationToPeriod(insideEndTouching)) == TimePeriodRelation.InsideEndTouching
    }
    
    func testTimePeriod_relationToPeriodEndInside_returnsEndInsideRelation() {
        expect(self.longPeriod.relationToPeriod(self.periodAfterOverlaps)) == TimePeriodRelation.EndInside
    }
    
    func testTimePeriod_relationToPeriodEndTouching_returnsEndTouchingRelation() {
        expect(self.longPeriod.relationToPeriod(self.periodAfterTouching)) == TimePeriodRelation.EndTouching
    }
    
    func testTimePeriod_relationToPeriodBefore_returnsBeforeRelation() {
        expect(self.longPeriod.relationToPeriod(self.periodAfter)) == TimePeriodRelation.Before
    }
    
    func testTimePeriod_relationToInvalidPeriod_returnsNoneRelation() {
        let invalidPeriod = TimePeriod(startDate: calendar.dateWithYear(2010), endDate: calendar.dateWithYear(1990), calendar: calendar)
        expect(self.longPeriod.relationToPeriod(invalidPeriod)) == TimePeriodRelation.None
    }
    
}
