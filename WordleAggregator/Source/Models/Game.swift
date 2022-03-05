//
//  Game.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import Foundation

struct Game: Hashable {
  var title: String
  var url: String

  static let quordle = Game(title: "Quordle", url: "https://www.quordle.com/#/")
  static let wordle = Game(title: "Wordle", url: "https://www.nytimes.com/games/wordle/index.html")
  static let wordle2 = Game(title: "Wordle2", url: "https://www.wordle2.in/")

  static let defaultList: [Game] = [wordle, wordle2, quordle]
}
