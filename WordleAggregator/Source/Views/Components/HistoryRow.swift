//
//  HistoryRow.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/2/22.
//

import SwiftUI

struct HistoryRow: View {
  var score: Score

  @State private var isAnswerHidden: Bool = true

  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .top) {
          Text(score.title ?? "")
            .foregroundColor(.white)
            .font(.footnote)
            .fontWeight(.semibold)
          Spacer()
          if score.isHardMode {
            hardModeBadge
          }
        }
        HStack {
          Text("\(score.numberOfGuesses) guesses")
            .foregroundColor(.white)
            .font(.system(size: 48))
            .minimumScaleFactor(0.5)
        }
        HStack {
          Text(score.date?.longDateString() ?? "")
            .foregroundColor(.white)
          Spacer()
          Text(score.answer?.uppercased() ?? "")
            .tracking(2)
            .foregroundColor(.white)
            .blur(radius: isAnswerHidden ? 6 : 0)
            .animation(.easeIn, value: isAnswerHidden)
        }
      }
    }
    .padding(8)
    .background(Colors.Background.Gradient.bottomToTop)
    .background(Colors.Background.Button.primary)
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
      Text("HARD MODE")
        .font(.system(size: 8))
        .fontWeight(.bold)
    }
    .padding(8)
    .foregroundColor(.white)
    .background(
      RoundedRectangle(cornerRadius: 6).fill(Colors.Text.infoHighlight)
    )
    .shadow(color: Colors.Shadows.primary, radius: 4, x: 2, y: 2)
  }
}

struct HistoryRow_Previews: PreviewProvider {
  static var previews: some View {
    let score = Score(context: CoreDataStack.context)
    score.answer = "crane"
    score.date = Date()
    score.numberOfGuesses = 4
    score.maxGuesses = 6
    score.title = "Wordle"
    score.memo = "275"
    score.isHardMode = true
    score.submissionTimestamp = Date()
    score.id = UUID()

    return HistoryRow(score: score)
      .previewLayout(.sizeThatFits)
  }
}
