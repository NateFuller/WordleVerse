//
//  ScoreHistoryViewModel.swift
//  Recordle
//
//  Created by Nathan Fuller on 4/4/22.
//

import SwiftUI

struct ScoreHistoryViewModel {
  var score: Score

  private var titleAndMemo: String {
    [score.title, score.memo].compactMap { $0 }.joined(separator: " ")
  }
  private var scoreString: String {
    guard score.success else { return "Miss" }

    let suffix = score.numberOfGuesses > 1 ? "guesses" : "guess"
    return "\(score.success ? "\(score.numberOfGuesses)" : "X") \(suffix)"
  }
  private var dateString: String {
    score.date?.longDateString() ?? ""
  }
  private var answer: String { score.answer ?? "" }

  var answerText: Text { Text(answer.uppercased()) }
  var backgroundColor: Color {
    score.success ? Colors.Button.Primary.background : Colors.Background.warning
  }
  var dateText: Text { Text(dateString) }

  var hardModeBadge: some View {
    guard score.isHardMode else { return AnyView(EmptyView()) }

    return AnyView(HStack(spacing: 0) {
      Image(systemName: "asterisk")
        .font(.system(size: 8, weight: .bold))
    }
    .padding(8)
    .foregroundColor(Colors.Text.primary)
    .background(
      Circle().fill(Colors.Background.infoHighlight)
    )
    .shadow(color: Colors.Shadows.primary, radius: 4, x: 2, y: 2))
  }

  var primaryText: Text { Text(scoreString) }
  var titleAndMemoText: Text { Text(titleAndMemo)}
}
