//
//  ScoreHistoryViewModel.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/4/22.
//

import SwiftUI

struct ScoreHistoryViewModel {
  var score: Score

  private var titleAndMemo: String {
    [score.title, score.memo].compactMap { $0 }.joined(separator: " ")
  }
  private var numGuesses: String {
    "\(score.success ? "\(score.numberOfGuesses)" : "X") guesses"
  }
  private var dateString: String {
    score.date?.longDateString() ?? ""
  }
  private var answer: String { score.answer ?? "" }

  var answerText: Text { Text(answer) }
  var backgroundColor: Color
  var dateText: Text { Text(dateString) }

  var hardModeBadge: some View {
    guard score.isHardMode else { return AnyView(EmptyView()) }

    return AnyView(HStack(spacing: 0) {
      Image(systemName: "asterisk")
        .font(.system(size: 8, weight: .bold))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
      Text("HARD MODE")
        .font(.system(size: 8))
        .fontWeight(.bold)
    }
    .padding(8)
    .foregroundColor(Colors.Text.primary)
    .background(
      RoundedRectangle(cornerRadius: 6).fill(Colors.Background.infoHighlight)
    )
    .shadow(color: Colors.Shadows.primary, radius: 4, x: 2, y: 2))
  }

  var titleAndMemoText: Text { Text(titleAndMemo)}
  var numGuessesText: Text { Text(numGuesses) }
}
