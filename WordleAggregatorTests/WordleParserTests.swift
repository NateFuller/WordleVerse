//
//  WordleParserTests.swift
//  WordleAggregatorTests
//
//  Created by Nathan Fuller on 3/21/22.
//

import Foundation
import XCTest
@testable import WordleAggregator

class WordleParserTests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }

  func testParseValidStringDoesNotThrow() {
    let resultText = String.winInThree

    XCTAssertNoThrow(try WordleParser.parse(resultText: resultText))
  }

  func testParseResultValues() {
    let resultText = String.winInThree

    do {
      let result = try WordleParser.parse(resultText: resultText)
      XCTAssertEqual(result.gameTitle, "Wordle")
      XCTAssertEqual(result.gameMemo, "275")
      XCTAssertEqual(result.numGuesses, 3)
      XCTAssertEqual(result.maxGuesses, 6)
      XCTAssertEqual(result.guessSummary.count, 3)
    } catch {
      XCTFail("Failed to parse \(resultText)")
    }
  }

  func testParseResultGuessSummaryWhenResultTextIsValid() {
    let resultText = String.winInThree

    do {
      let guessSummary = try WordleParser.parse(resultText: resultText).guessSummary

      XCTAssertEqual(guessSummary[0], "BYBBB")
      XCTAssertEqual(guessSummary[1], "BGBYY")
      XCTAssertEqual(guessSummary[2], "GGGGG")
    } catch { XCTFail("Failed to parse \(resultText)") }
  }

  func testConvertEmojiWhenUsingValidEmoji() {
    XCTAssertEqual(try WordleParser.convertEmoji("⬛"), "B")
    XCTAssertEqual(try WordleParser.convertEmoji("🟨"), "Y")
    XCTAssertEqual(try WordleParser.convertEmoji("🟩"), "G")

    XCTAssertEqual(try WordleParser.convertEmoji("⬛🟨⬛⬛⬛"), "BYBBB")
    XCTAssertEqual(try WordleParser.convertEmoji("⬛🟩⬛🟨🟨"), "BGBYY")
    XCTAssertEqual(try WordleParser.convertEmoji("🟩🟩🟩🟩🟩"), "GGGGG")
  }

  func testConvertEmojiThrowsWhenUsingInvalidEmoji() {
    XCTAssertThrowsError(try WordleParser.convertEmoji("🤷🏻‍♂️"))
    XCTAssertThrowsError(try WordleParser.convertEmoji("BYG"))
    XCTAssertThrowsError(try WordleParser.convertEmoji("🟥"))
  }
}
