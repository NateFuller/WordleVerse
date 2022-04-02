//
//  Game+CoreData.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import Foundation
import CoreData

struct Game: Codable, Hashable {
  var title: String
  var enabled: Bool

  /// The maximum number of guesses a user has to correctly guess all `numberOfAnswers` words.
  var maxGuesses: Int

  /// The URL a user navigates to in order to play this game.
  var url: String

  /**
   The number of words the game has you attempt to guess.

   Games like Wordle and Wordle2 only have a user guess 1
   word, but games like Quordle and Octordle have users guess 4 and 8 words, respectively.
   */
  var numberOfAnswers: Int

  /** The number of characters that each answer has.

   Assumes that if `numberOfAnswers` > 1, all separate words are the
   same in length.
   */
  var answerLength: Int

  var resetHour: Int
  var resetMinute: Int
}

extension Game {
  struct Defaults {
    static let all: [Game] = [Game.Defaults.wordle, Game.Defaults.wordle2]
    static let wordle = Game(title: "Wordle",
                             enabled: true,
                             maxGuesses: 6,
                             url: "https://www.nytimes.com/games/wordle/index.html",
                             numberOfAnswers: 1,
                             answerLength: 5,
                             resetHour: 0,
                             resetMinute: 0)
    static let wordle2 = Game(title: "Wordle2",
                              enabled: false,
                              maxGuesses: 6,
                              url: "https://www.wordle2.in/",
                              numberOfAnswers: 1,
                              answerLength: 6,
                              resetHour: 0,
                              resetMinute: 0)
  }
}
