//
//  ScoreSubmissionView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct ScoreSubmissionView: View {
  var game: Game

  @State private var answerInput: String = ""
  @State private var isAnswerInfoAlertVisible: Bool = false
  @State private var numGuesses: Double = 1

  private var isInputFilled: Bool { answerInput.length == game.answerLength }
  private var sliderColor: Color

  init(game: Game) {
    self.game = game
    sliderColor = Colors.Background.Button.primary
  }

  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Text("what was today's word?")
          .font(.title3).fontWeight(.bold)
          .frame(alignment: .leading)
        Button(action: { isAnswerInfoAlertVisible = true }) {
          Image(systemName: "info.circle")
            .foregroundColor(Colors.Background.Button.secondary)
        }.alert(isPresented: $isAnswerInfoAlertVisible) {
          Alert(title: Text("What's the word?"),
                message: Text("Don’t know the word yet? No worries! You can add this later on the ‘History’ page!"),
                dismissButton: .cancel(Text("Siiick!")))
        }
        Spacer()
      }
      WordleInputField(length: game.answerLength, inputText: $answerInput)
      HStack {
        Text("how many guesses did you make?")
          .font(.title3).fontWeight(.bold)
          .frame(alignment: .leading)
        Spacer()
      }
      Slider(value: $numGuesses, in: 1...Double(game.maxGuesses), step: 1)
        .tint(sliderColor)
      Text("\(Int(numGuesses)) \(numGuesses > 1 ? "guesses" : "guess")")
        .font(.largeTitle).fontWeight(.semibold)

      Button(action: {}) {
        Text(isInputFilled ? "Submit" : "I failed this time 😭")
          .foregroundColor(.white)
          .font(.body).fontWeight(.semibold)
          .frame(width: 191, height: 50)
          .background(isInputFilled ? Colors.Background.Button.primary : Colors.Background.Button.tertiary)
          .cornerRadius(8)
      }
      Spacer()
    }
    .navigationTitle("today's \(game.title)")
    .padding(16)
  }

  private func endEditing() {
    UIApplication.shared.endEditing()
  }
}

struct ScoreSubmissionView_Previews: PreviewProvider {
  static var previews: some View {
    ScoreSubmissionView(game: Game.Defaults.wordle2)
      .preferredColorScheme(.dark)
  }
}
