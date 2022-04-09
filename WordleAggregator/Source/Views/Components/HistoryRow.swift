//
//  HistoryRow.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/2/22.
//

import SwiftUI

struct HistoryRow: View {
  var viewModel: ScoreHistoryViewModel

  @State private var isAnswerHidden: Bool = true

  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .top) {
          viewModel.titleAndMemoText
            .foregroundColor(Colors.Text.primary)
            .font(.footnote)
            .fontWeight(.semibold)
          Spacer()
          viewModel.hardModeBadge
        }
        HStack {
          viewModel.primaryText
            .foregroundColor(Colors.Text.primary)
            .font(.system(size: 48))
            .minimumScaleFactor(0.5)
        }
        HStack {
          viewModel.dateText
            .foregroundColor(Colors.Text.primary)
          Spacer()
          viewModel.answerText
            .tracking(2)
            .foregroundColor(Colors.Text.primary)
            .blur(radius: isAnswerHidden ? 6 : 0)
            .animation(.easeIn, value: isAnswerHidden)
        }
      }
    }
    .padding(8)
    .background(Colors.Background.Gradient.bottomToTop)
    .background(viewModel.backgroundColor)
    .cornerRadius(8)
    .onTapGesture {
      isAnswerHidden.toggle()
    }
  }

  var hardModeBadge: some View {
    HStack(spacing: 0) {
      Image(systemName: "asterisk")
        .font(.system(size: 8, weight: .bold))
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
    }
    .padding(8)
    .foregroundColor(Colors.Text.primary)
    .background(
      RoundedRectangle(cornerRadius: 6).fill(Colors.Background.infoHighlight)
    )
    .shadow(color: Colors.Shadows.primary, radius: 4, x: 2, y: 2)
  }
}

struct HistoryRow_Previews: PreviewProvider {
  static var previews: some View {
    let score = Score(context: CoreDataStack.context)
    score.answer = "crane"
    score.date = Date()
    score.numberOfGuesses = 7
    score.maxGuesses = 6
    score.title = "Wordle"
    score.memo = "275"
    score.isHardMode = false
    score.submissionTimestamp = Date()
    score.id = UUID()

    return HistoryRow(viewModel: ScoreHistoryViewModel(score: score))
      .preferredColorScheme(.dark)
      .previewLayout(.sizeThatFits)
  }
}
