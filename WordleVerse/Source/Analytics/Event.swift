//
//  Event.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/10/22.
//

import Foundation

struct Event {
  var name: Name
  var parameters: [String: Any]?

  struct Name: RawRepresentable, Equatable {
    var rawValue: String
    init(rawValue: String) { self.rawValue = rawValue }
    init(_ rawValue: String) { self.init(rawValue: rawValue) }

    static let historyRowTapped = Self("history_row_tapped")
    static let historyRowDeleted = Self("history_row_deleted")
    static let historyRowDeletionError = Self("history_row_deletion_error")
    static let pasteResultsError = Self("paste_results_error")
    static let pasteResultsSuccess = Self("paste_results_success")
    static let pasteResultsSkipped = Self("paste_results_skipped")
    static let scoreSubmissionInfoDisclosureTapped = Self("score_submission_info_disclosure_tapped")
    static let scoreSubmissionGuessesUpdated = Self("score_submission_guesses_updated")
    static let scoreSubmissionHardModeUpdated = Self("score_submission_hard_mode_updated")
    static let scoreSubmitted = Self("score_submitted")
  }

  struct ParameterKey {
    static let errorMessage = "error_message"
  }
}
