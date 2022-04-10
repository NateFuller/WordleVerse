//
//  TestScores.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/3/22.
//

import CoreData

class TestScores: TestData {
  init(context: NSManagedObjectContext) {
    super.init(context: context, entityName: "Score")
  }

  override func addRows() throws {
    guard super.noRowsExist() else { return }

    for (i, answer) in ["crane", "tweak", "trope"].enumerated() {
      let score = Score(context: context)
      score.answer = answer
      score.date = Date(timeIntervalSinceNow: -1 * 60*60*24 * TimeInterval(i))
      score.id = UUID()
      score.isHardMode = Bool.random()
      score.numberOfGuesses = Int64.random(in: 1...6)
      score.maxGuesses = 6
      score.memo = "\(Int64.random(in: 100...999))"
      score.submissionTimestamp = Date(timeIntervalSinceNow: -1 * 60*60*24 * TimeInterval(i))
      score.title = "Wordle"
    }

    try! context.save()
  }

  override func getRows() throws -> [Any]? {
    return try super.getRows()
  }

  func getRows(count: Int) throws -> [Score] {
    return try super.getRows(count: count)
  }
}
