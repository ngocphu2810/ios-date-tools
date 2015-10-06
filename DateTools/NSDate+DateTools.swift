//
//  NSDate+DateTools.swift
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

public enum DateComponent: Int {
    case Era
    case Year
    case Month
    case Day
    case Hour
    case Minute
    case Second
    case Weekday
    case WeekdayOrdinal
    case Quarter
    case WeekOfMonth
    case WeekOfYear
    case YearForWeekOfYear
    case DayOfYear
}

public extension NSDate {
    
    public class func dateWithYear(year: Int = 1970, month: Int = 1, day: Int = 1, hour: Int = 0, minute: Int = 0, second: Int = 0) -> NSDate {
        let components = NSDateComponents()
        
        components.year   = year
        components.month  = month
        components.day    = day
        components.hour   = hour
        components.minute = minute
        components.second = second
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }

    //MARK: - adding components to date methods
    
    public func dateByAddingYears(years: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingYears(years, toDate: self)
    }
    
    public func dateByAddingMonths(months: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingMonths(months, toDate: self)
    }
    
    public func dateByAddingWeeks(weeks: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingWeeks(weeks, toDate: self)
    }
    
    public func dateByAddingDays(days: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingDays(days, toDate: self)
    }
    
    public func dateByAddingHours(hours: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingHours(hours, toDate: self)
    }
    
    public func dateByAddingMinutes(minutes: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingMinutes(minutes, toDate: self)
    }
    
    public func dateByAddingSeconds(seconds: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingSeconds(seconds, toDate: self)
    }
    
    //MARK: - subtracting components from date methods
    
    public func dateBySubtractingYears(years: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingYears(years, toDate: self)
    }
    
    public func dateBySubtractingMonths(months: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingMonths(months, toDate: self)
    }
    
    public func dateBySubtractingWeeks(weeks: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingWeeks(weeks, toDate: self)
    }
    
    public func dateBySubtractingDays(days: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingDays(days, toDate: self)
    }
    
    public func dateBySubtractingHours(hours: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingHours(hours, toDate: self)
    }
    
    public func dateBySubtractingMinutes(minutes: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingMinutes(minutes, toDate: self)
    }
    
    public func dateBySubtractingSeconds(seconds: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateBySubtractingSeconds(seconds, toDate: self)
    }

    
    public func hoursFrom(date: NSDate) -> Double {
        return self.timeIntervalSinceDate(date) / Double(SECONDS_IN_HOUR)
    }
    
    public func minutesFrom(date: NSDate) -> Double {
        return self.timeIntervalSinceDate(date) / Double(SECONDS_IN_MINUTE)
    }
    
    public func secondsFrom(date: NSDate) -> Double {
        return self.timeIntervalSinceDate(date)
    }
    
}

//MARK: - Comparators

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 == rhs.timeIntervalSince1970
}

public func != (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 != rhs.timeIntervalSince1970
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 < rhs.timeIntervalSince1970
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 > rhs.timeIntervalSince1970
}

public func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 <= rhs.timeIntervalSince1970
}

public func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSince1970 >= rhs.timeIntervalSince1970
}

public func + (lhs: NSCalendarUnit, rhs: NSCalendarUnit) -> NSCalendarUnit {
    var unit = lhs
    unit.insert(rhs)
    return unit
}
