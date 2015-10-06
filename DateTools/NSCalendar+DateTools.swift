//
//  NSCalendar+DateTools.swift
//  DateTools
//
// Copyright 2015 Codewise sp. z o.o. Sp. K.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

public let allCalendarUnitFlags: NSCalendarUnit = NSCalendarUnit.Year + NSCalendarUnit.Quarter + NSCalendarUnit.Month + NSCalendarUnit.Day + NSCalendarUnit.Hour + NSCalendarUnit.Second + NSCalendarUnit.Weekday + NSCalendarUnit.WeekdayOrdinal + NSCalendarUnit.Quarter + NSCalendarUnit.WeekOfMonth + NSCalendarUnit.WeekOfYear + NSCalendarUnit.YearForWeekOfYear


public extension NSCalendar {
    
    public func dateWithYear(year: Int = 1970, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> NSDate {
        let components = NSDateComponents()
        
        components.year   = year
        components.month  = month
        components.day    = day
        components.hour   = hour
        components.minute = minute
        components.second = second
        
        return self.dateFromComponents(components)!
    }
    
    //MARK: - adding components to date methods
    
    public func dateByAddingYears(years: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.year = years
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateByAddingMonths(months: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = months
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateByAddingWeeks(weeks: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.weekOfYear = weeks
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateByAddingDays(days: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.day = days
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateByAddingHours(hours: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.hour = hours
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateByAddingMinutes(minutes: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.minute = minutes
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateByAddingSeconds(seconds: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.second = seconds
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    //MARK: - subtracting components from date methods
    
    public func dateBySubtractingYears(years: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.year = -years
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateBySubtractingMonths(months: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.month = -months
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateBySubtractingWeeks(weeks: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.weekOfYear = -weeks
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateBySubtractingDays(days: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.day = -days
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateBySubtractingHours(hours: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.hour = -hours
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateBySubtractingMinutes(minutes: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.minute = -minutes
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    public func dateBySubtractingSeconds(seconds: Int, toDate date: NSDate) -> NSDate {
        let dateComponents = NSDateComponents()
        dateComponents.second = -seconds
        return self.dateByAddingComponents(dateComponents, toDate: date, options: [])!
    }
    
    //MARK: - number of components between dates
    
    public func yearsFrom(fromDate: NSDate, toDate date: NSDate) -> Int {
        let earliest = fromDate.earlierDate(date)
        let latest = earliest == fromDate ? date : fromDate
        let multiplier = earliest == fromDate ? -1 : 1
        let components = self.components(NSCalendarUnit.Year, fromDate: earliest, toDate: latest, options: [])
        return multiplier * components.year
    }
    
    public func monthsFrom(fromDate: NSDate, toDate date: NSDate) -> Int {
        let earliest = fromDate.earlierDate(date)
        let latest = earliest == fromDate ? date : fromDate
        let multiplier = earliest == fromDate ? -1 : 1
        let components = self.components(allCalendarUnitFlags, fromDate: earliest, toDate: latest, options: [])
        return multiplier * (components.month + 12 * components.year)
    }
    
    public func weeksFrom(fromDate: NSDate, toDate date: NSDate) -> Int {
        let earliest = fromDate.earlierDate(date)
        let latest = earliest == fromDate ? date : fromDate
        let multiplier = earliest == fromDate ? -1 : 1
        let components = self.components(NSCalendarUnit.WeekOfYear, fromDate: earliest, toDate: latest, options: [])
        return multiplier * components.weekOfYear
    }
    
    public func daysFrom(fromDate: NSDate, toDate date: NSDate) -> Int {
        let earliest = fromDate.earlierDate(date)
        let latest = earliest == fromDate ? date : fromDate
        let multiplier = earliest == fromDate ? -1 : 1
        let components = self.components(NSCalendarUnit.Day, fromDate: earliest, toDate: latest, options: [])
        return multiplier * components.day
    }
    
    //MARK: - Earlier than
    
    public func yearsEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Int {
        return abs(min(self.yearsFrom(forDate, toDate: date), 0))
    }
    
    public func monthsEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Int {
        return abs(min(self.monthsFrom(forDate, toDate: date), 0))
    }
    
    public func weeksEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Int {
        return abs(min(self.weeksFrom(forDate, toDate: date), 0))
    }
    
    public func daysEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Int {
        return abs(min(self.daysFrom(forDate, toDate: date), 0))
    }
    
    public func hoursEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Double {
        return abs(min(forDate.hoursFrom(date), 0))
    }
    
    public func minutesEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Double {
        return abs(min(forDate.minutesFrom(date), 0))
    }
    
    public func secondsEarlierFor(forDate: NSDate, thanDate date: NSDate) -> Double {
        return abs(min(forDate.secondsFrom(date), 0))
    }
    
    public class func isLeapYear(year: Int) -> Bool {
        return (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))
    }

    

    
}