//
//  WordleParser.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/21/22.
//

import Foundation

enum WordleParseError: Error {
  case inputTextNotValid
  case scoreNotValid
  case emojiSummaryNotValid
}

/// A utility class for parsing a user's pasted results from Wordle
class WordleParser {

  /**
   Parses the user's pasted text from Wordle.

   The text should be formatted as following or else this method will throw a `WordleParseError`:
   ```
   Wordle 275 3/6

   ⬛🟨⬛⬛⬛
   ⬛🟩⬛🟨🟨
   🟩🟩🟩🟩🟩
   ```

   - Parameter resultText: The text to be parsed.
   - Returns: A `ParseResult` containing the data from the user's `resultText`.
   - Throws: An error of type `WordleParseError`

   */
  static func parse(resultText: String) throws -> ParseResult {
    let parts = resultText.components(separatedBy: .whitespacesAndNewlines).compactMap { $0.isEmpty ? nil : $0 }
    guard parts.count > 3 else { throw WordleParseError.inputTextNotValid }

    let scoreParts = parts[2].split(separator: "/").compactMap { Int($0) }
    guard scoreParts.count == 2 else { throw WordleParseError.inputTextNotValid }
    guard scoreParts[0] <= scoreParts[1] else { throw WordleParseError.scoreNotValid }

    let numGuesses = scoreParts[0]

    let firstGuessIndex = 3
    var guessSummary: [String] = []
    for index in firstGuessIndex..<(firstGuessIndex + numGuesses) {
      guessSummary.append(try convertEmoji(parts[index]))
    }

    return ParseResult(gameTitle: parts[0],
                       gameMemo: parts[1],
                       numGuesses: numGuesses,
                       maxGuesses: scoreParts[1],
                       guessSummary: guessSummary)
  }

  static func convertEmoji(_ emojiText: String) throws -> String {
    var converted = ""
    for i in 0..<emojiText.length {
      switch emojiText[i] {
      case "⬛":
        converted.append(contentsOf: "B")
      case "🟨":
        converted.append(contentsOf: "Y")
      case "🟩":
        converted.append(contentsOf: "G")
      default:
        throw WordleParseError.emojiSummaryNotValid
      }
    }

    return converted
  }
}

struct ParseResult {
  var gameTitle: String
  var gameMemo: String
  var numGuesses: Int
  var maxGuesses: Int
  var guessSummary: [String]
}
