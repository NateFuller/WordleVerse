//
//  ScoreSubmissionView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct ScoreSubmissionView: View {
  var gameWordLength: Int

  @State private var sliderPercentage: Float = 0.5
  @State private var numGuesses: Int = 0
  @State private var answerInput: String = ""

  private var isInputFilled: Bool {
    answerInput.length == gameWordLength
  }

  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Text("what was today's word?")
          .font(.title3).fontWeight(.bold)
          .frame(alignment: .leading)
        Image(systemName: "info.circle").foregroundColor(Color.accentColor)
        Spacer()
      }
      WordleInputField(length: gameWordLength, inputText: $answerInput)
      HStack {
        Text("how many guesses did you make?")
          .font(.title3).fontWeight(.bold)
          .frame(alignment: .leading)
        Spacer()
      }
      Slider(value: $sliderPercentage)
      Text("\(numGuesses) guesses")
        .font(.largeTitle).fontWeight(.semibold)

      Button(action: {}) {
        Text(isInputFilled ? "Submit" : "I failed this time 😭")
          .foregroundColor(.white)
          .font(.body).fontWeight(.semibold)
      }
      .frame(width: 191, height: 50)
      .background(isInputFilled ? Colors.Background.Button.primary : Colors.Background.Button.tertiary)
      .buttonStyle(.bordered)
      .cornerRadius(8)

      Spacer()
    }
    .navigationTitle("what was today's word?")
    .padding(16)
  }
}

struct ScoreSubmissionView_Previews: PreviewProvider {
  static var previews: some View {
    ScoreSubmissionView(gameWordLength: 5)
      .preferredColorScheme(.dark)
  }
}
