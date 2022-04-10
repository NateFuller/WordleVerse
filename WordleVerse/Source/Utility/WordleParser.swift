//
//  WordleParser.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 3/21/22.
//

import Foundation

enum WordleParseError: Error {
  case inputTextNotValid
  case scoreNotValid(score: String)
  case emojiSummaryDoesNotMatch(score: String, numGuesses: String)
  case emojiSummaryNotValid
}

extension WordleParseError : LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .inputTextNotValid: return "Something about your results doesn't look right!"
    case .scoreNotValid(let score): return "Your score '\(score)' doesn't look right!"
    case .emojiSummaryDoesNotMatch(let score, let numGuesses):
      return "Based on your score '\(score)', your emoji summary should contain exactly \(numGuesses) rows."
    case .emojiSummaryNotValid: return "The emoji summary of your guesses doesn't look right!"
    }
  }
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
    guard parts.count >= 4 else { throw WordleParseError.inputTextNotValid }

    var isHardMode = false
    var scoreString = parts[2]

    if scoreString.contains("*") { // hard mode
      isHardMode = true
      scoreString = scoreString.substring(toIndex: scoreString.length - 1)
    }

    let scoreParts = scoreString.split(separator: "/")
    guard scoreParts.count == 2, let maxGuesses = Int(scoreParts[1]) else {
      throw WordleParseError.scoreNotValid(score: scoreString)
    }

    let numGuesses = Int(scoreParts[0])
    guard numGuesses == nil || (numGuesses! > 0 && numGuesses! <= maxGuesses) else {
      throw WordleParseError.scoreNotValid(score: scoreString)
    }

    let firstGuessIndex = 3
    var guessSummary: String = ""
    guard firstGuessIndex + (numGuesses ?? maxGuesses) == parts.count else {
      throw WordleParseError.emojiSummaryDoesNotMatch(score: scoreString, numGuesses: "\(numGuesses ?? maxGuesses)")
    }

    for index in firstGuessIndex..<(firstGuessIndex + (numGuesses ?? maxGuesses)) {
      guard parts[index].length == Game.Defaults.wordle.answerLength else {
        throw WordleParseError.emojiSummaryNotValid
      }

      guessSummary.append("\(try convertEmoji(parts[index]))\n")
    }

    return ParseResult(success: numGuesses != nil,
                       gameTitle: parts[0],
                       gameMemo: parts[1],
                       isHardMode: isHardMode,
                       numGuesses: numGuesses ?? maxGuesses + 1,
                       maxGuesses: maxGuesses,
                       guessSummary: guessSummary.trimmingCharacters(in: .newlines))
  }

  static func convertEmoji(_ emojiText: String) throws -> String {
    var converted = ""
    for i in 0..<emojiText.length {
      switch emojiText[i] {
      case "⬛", "⬜":
        converted.append(contentsOf: "M")
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
