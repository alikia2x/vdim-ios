//
//  TimeFormatter.swift
//  vdim
//
//  Created by Alikia2x on 2025/1/22.
//

import Foundation

/// Formats a date as a relative string (e.g., "2 hours ago").
/// - Parameters:
///   - timestamp: The date to format.
///   - referenceDate: The reference date (defaults to the current date).
///   - unitsStyle: The style of the units (e.g., `.full`, `.short`, `.abbreviated`).
///   - dateTimeStyle: The style of the date/time (e.g., `.named`, `.numeric`).
/// - Returns: A formatted relative date string.
func formatRelativeDate(
    _ timestamp: Int,
    relativeTo referenceDate: Date = Date(),
    unitsStyle: RelativeDateTimeFormatter.UnitsStyle = .full,
    dateTimeStyle: RelativeDateTimeFormatter.DateTimeStyle = .numeric
) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = unitsStyle
    formatter.dateTimeStyle = dateTimeStyle
    
    let interval = TimeInterval(timestamp)
    let date = Date(timeIntervalSince1970: interval)
    
    return formatter.localizedString(for: date, relativeTo: referenceDate)
}
