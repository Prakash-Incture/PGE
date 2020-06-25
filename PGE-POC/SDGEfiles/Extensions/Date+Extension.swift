//
//  Date+Extension.swift
//  SDGE Near Miss
//
//  Created by Ujwal K Raikar on 11/10/19.
//  Copyright © 2019 Incture. All rights reserved.
//

import Foundation

extension Date {
    // https://nsdateformatter.com
    enum DateFormat: String {
        //        case yearMonthDateBarSeparator = "MM-dd-yyyy"
        case yearMonthDateHypenSeparator = "YYYY-MM-dd"
        case yearMonthDateBarSeparator = "YYYY/MM/dd"
        case monthDateYearHiphenSeparator = "MM-dd-yyyy"
        case long = "yyyy-MM-dd HH:mm:ss"
        case long12HourFormat = "yyyy-MM-dd h:mm:ss a"
        case monthDateYearLong = "MM-dd-yyyy HH:mm:ss"
        case dayMonthYear = "dd MMM yyyy"
        case dayMonth = "dd MMM"
        case short = "hh:mm a"
        case shortWithoutAmPm = "hh:mm"
        case hourMinuteSecondsGlobalFormat = "HH:mm:ss"
        case hourMinuteSecondsLocalFormat = "hh:mm:ss"
        case dayMonthYearwithTime = "dd MMM yyyy HH:mm a"
        case yearMonthDateMilliSeconds = "yyyy-MM-dd'T'HH:mm:ssZ"
        case yearMonthDateTime = "yyyy-MM-dd'T'HH:mm:ss"
        case monthDayCommaYear = "MMM d, yyyy"
        case dayCommaMonthDayYear = "E, MMM d yyyy"
        case dayCommaMonthDayYearTimeShort = "E, MMM d yyyy hh:mm a"
        case yearMonthdayNoSeperator = "yyyyMMdd"
        case dayMonthYearBarSeperator = "dd/MM/yyyy"
        case dayMonthYearDotSeperator = "dd.MM.yyyy"
        case hoursMinutesSecondsNoSeperator = "hhmmss"
        case yearMonthDateMilliSeconds2 = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        case hourMinuteSecondsGlobalFormatNoSeperator = "HHmmss"
        case monthYear = "MMM, yyyy"
        case monthDay = "E, d"
        case weekDayCommaMonthYear = "E d, MMM"
        case shortGlobalFormat = "HH:mm"
        case dayMonthYearHypenSeperator = "dd-MMM-yyyy"
    }
    
    
    func toDateFormat(_ format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func timeAgoSinceDate() -> String {
        
        // From Time
        let fromDate = self
        
        // To Time
        let toDate = Date()
        
        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + NSLocalizedString("YEAR_AGO", comment: "") : "\(interval)" + " " + "\(NSLocalizedString("YEARS_AGO", comment: ""))"
        }
        
        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "\(NSLocalizedString("MONTH_AGO", comment: ""))" : "\(interval)" + " " + "\(NSLocalizedString("MONTHS_AGO", comment: ""))"
        }
        
        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {
            
            return interval == 1 ? "\(interval)" + " " + "\(NSLocalizedString("DAY_AGO", comment: ""))" : "\(interval)" + " " + NSLocalizedString("DAYS_AGO", comment: "")
        }
        
        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "\(NSLocalizedString("HOUR_AGO", comment: ""))" : "\(interval)" + " " + NSLocalizedString("HOURS_AGO", comment: "")
        }
        
        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {
            
            return interval == 1 ? "\(interval)" + " " + "\(NSLocalizedString("MIN_AGO", comment: ""))" : "\(interval)" + " " + "\(NSLocalizedString("MINS_AGO", comment: ""))"
        }
        
        if let interval = Calendar.current.dateComponents([.second], from: fromDate, to: toDate).second, interval > 0 {
            
            return interval >= 3 ? "\(interval)" + " " + "\(NSLocalizedString("SECS_AGO", comment: ""))" : "\(NSLocalizedString("JUST_NOW", comment: ""))"
        }
        
        return "JUST_NOW"
    }

    
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (date1.compare(self) == .orderedAscending) && (date2.compare(self) == .orderedDescending)

    }
    
//    func toDateFormat(_ format: DateFormat, isUTCTimeZone: Bool = false) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format.rawValue
//        if isUTCTimeZone {
//            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        }
//        //        dateFormatter.locale = locale
//        let dateString = dateFormatter.string(from: self)
//        return dateString
//    }
    
    private func getCalender(component: Calendar.Component) -> Int? {
        let units: Set<Calendar.Component> = [.hour, .day, .month, .year, .minute, .second, .weekday]
        let calenderComponents = Calendar.current.dateComponents(units, from: self)
        
        var returnValue: Int?
        switch component {
        case .hour:
            returnValue = calenderComponents.hour
            break
        case .day:
            returnValue = calenderComponents.day
            break
        case .month:
            returnValue = calenderComponents.month
            break
        case .year:
            returnValue = calenderComponents.year
            break
        case .minute:
            returnValue = calenderComponents.minute
        case .second:
            returnValue = calenderComponents.second
        case .weekday:
            returnValue = calenderComponents.weekday
        default:
            break
        }
        
        return returnValue
    }
    
    /// Returns Month of the date
    var month: Int? {
        return self.getCalender(component: .month)
    }
    
    /// Returns day of the date
    var day: Int? {
        return self.getCalender(component: .day)
    }
    
    /// Returns only hour of the date
    var hour: Int? {
        return self.getCalender(component: .hour)
    }
    
    /// Returns year of the date
    var year: Int? {
        return self.getCalender(component: .year)
    }
    
    /// Returns minutes of the date
    var minutes: Int? {
        return self.getCalender(component: .minute)
    }
    
    var seconds: Int? {
        return self.getCalender(component: .second)
    }
    
    var weekDay: Int? {
        return self.getCalender(component: .weekday)
    }
    func toFormat(_ format: String = "yyyyMMdd") -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = format
        return dateFormater.string(from: self)
    }
    
    func compareTimeOnly(to: Date) -> ComparisonResult {
        let calendar = Calendar.current
        let toDate = calendar.date(bySettingHour: to.hour!, minute: to.minutes!, second: 0, of: self)!
        let seconds = calendar.dateComponents([.second], from: self, to: toDate).second!
        if seconds == 0 {
            return .orderedSame
        } else if seconds > 0 {
            // Ascending means before
            return .orderedAscending
        } else {
            // Descending means after
            return .orderedDescending
        }
    }
    
    static func getTimeDifference(from date1: Date, to date2: Date, unitStyle: DateComponentsFormatter.UnitsStyle = .full, allowedUnits: NSCalendar.Unit = [.hour, .minute]) -> String? {
        
        let timeInterval = date1.timeIntervalSince1970 - date2.timeIntervalSince1970
        let formatter = DateComponentsFormatter()
        let calendar = Calendar.current
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = .full
        formatter.calendar = calendar
        return formatter.string(from: timeInterval)
    }
}
