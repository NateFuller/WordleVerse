//
//  Date+Formatting.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/2/22.
//

import Foundation

extension Date {
  func longDateString() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none

    return formatter.string(from: self)
  }
}
