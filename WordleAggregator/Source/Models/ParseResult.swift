//
//  ParseResult.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/1/22.
//

import Foundation

struct ParseResult {
  var gameTitle: String
  var gameMemo: String
  var isHardMode: Bool
  var numGuesses: Int
  var maxGuesses: Int
  var guessSummary: [String]
}

extension ParseResult {
  static var fixture: ParseResult { try! WordleParser.parse(resultText: .winInThree) }
}
