//
//  FirebaseManager.swift
//  Recordle
//
//  Created by Nathan Fuller on 4/10/22.
//

import Foundation
import FirebaseAnalytics

class FirebaseManager: AnalyticsLoggable {
  static func logScreen(_ screen: Screen) {
    var parameters = screen.additionalParameters ?? [:]
    parameters[AnalyticsParameterScreenName] = screen.name
    parameters[AnalyticsParameterScreenClass] = screen.`class`

    Analytics.logEvent(AnalyticsEventScreenView,
                       parameters: parameters)
  }

  static func logEvent(name: Event.Name, parameters: [String: Any]? = nil) {
    Analytics.logEvent(name.rawValue, parameters: parameters)
  }
}
