//
//  FirebaseManager.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/10/22.
//

import Foundation
import FirebaseAnalytics

class FirebaseManager {
  static func logScreen(_ screen: Screen) {
    Analytics.logEvent(AnalyticsEventScreenView,
                       parameters: [AnalyticsParameterScreenName: screen.name,
                                   AnalyticsParameterScreenClass: screen.class])
  }
}
