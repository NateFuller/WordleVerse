//
//  ParseResult.swift
//  Recordle
//
//  Created by Nathan Fuller on 4/1/22.
//

import Foundation

struct ParseResult {
  var success: Bool
  var gameTitle: String
  var gameMemo: String
  var isHardMode: Bool
  var numGuesses: Int
  var maxGuesses: Int
  var guessSummary: String
}

extension ParseResult {
  static var emptyWordle = ParseResult(success: false,
                                       gameTitle: Game.Defaults.wordle.title,
                                       gameMemo: "",
                                       isHardMode: false,
                                       numGuesses: Game.Defaults.wordle.maxGuesses + 1,
                                       maxGuesses: Game.Defaults.wordle.maxGuesses,
                                       guessSummary: "")
  static var fixture: ParseResult { try! WordleParser.parse(resultText: .winInThree) }
}
