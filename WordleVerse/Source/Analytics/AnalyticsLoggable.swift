//
//  AnalyticsLoggable.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/10/22.
//

import Foundation

protocol AnalyticsLoggable {
  static func logEvent(name: Event.Name, parameters: [String: Any]?)
  static func logScreen(_ screen: Screen)
}

extension AnalyticsLoggable {
  static func logEvent(name: Event.Name, parameters: [String: Any]? = nil) {
    logEvent(name: name, parameters: parameters)
  }
}
