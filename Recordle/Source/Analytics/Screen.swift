//
//  Screen.swift
//  Recordle
//
//  Created by Nathan Fuller on 4/10/22.
//

import Foundation

struct Screen {
  var name: String
  var `class`: String
  var additionalParameters: [String : Any]?

  static let home = Screen(name: "home", class: "\(HomeScreenView.self)")
  static let pasteResults = Screen(name: "paste_results", class: "\(PasteResultsView.self)")
  static let scoreHistory = Screen(name: "score_history", class: "\(ScoreHistoryView.self)")
  static let scoreSubmission = Screen(name: "score_submission", class: "\(ScoreSubmissionView.self)")

  static func game(title: String, url: String) -> Screen {
    return Screen(name: "game_wk_view",
                  class: "\(GameWebView.self)",
                  additionalParameters: [ParameterKey.gameTitle: title,
                                         ParameterKey.gameURL: url])
  }

  struct ParameterKey {
    static let gameTitle = "game_title"
    static let gameURL = "game_url"
  }
}
