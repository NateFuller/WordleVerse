//
//  ScoreSubmissionView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct ScoreSubmissionView: View {
  var game: Game
  var parseResult: ParseResult?

  @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

  @State private var answerInput: String = ""
  @State private var errorMessage: String? { didSet { isErrorState = !errorMessage.isNilOrEmpty }}
  @State private var isAnswerInfoAlertVisible: Bool = false
  @State private var isErrorState: Bool = false
  @State private var isReportingFail: Bool = false
  @State private var isHardMode: Bool = false
  @State private var numGuesses: Double = 6

  private var sliderColor: Color
  private var isInputFilled: Bool { answerInput.length == game.answerLength }
  private var maxGuesses: Int { parseResult?.maxGuesses ?? game.maxGuesses }

  init(game: Game, parseResult: ParseResult?) {
    self.game = game
    if let parseResult = parseResult {
      self.parseResult = parseResult
      self.isHardMode = parseResult.isHardMode
      self.numGuesses = Double(parseResult.numGuesses)
    }
    self.sliderColor = Colors.Background.Button.primary
  }

  var body: some View {
    Background {
      ScrollView {
        VStack(spacing: 16) {
          HStack {
            Text("what was today's word?")
              .font(.title3).fontWeight(.bold)
              .frame(alignment: .leading)
            Button(action: { isAnswerInfoAlertVisible = true }) {
              Image(systemName: "info.circle")
                .foregroundColor(Colors.Background.Button.secondary)
            }
            .alert(isPresented: $isAnswerInfoAlertVisible) {
              Alert(title: Text("What's the word?"),
                    message: Text("Don’t know the word yet? I'm working on being able to update this later from the History screen 😉"),
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

          // TODO make slider have 1 extra value at end indicating failure
          Slider(value: $numGuesses, in: 1...Double(maxGuesses + 1), step: 1)
            .tint(sliderColor)

          Text("\(Int(numGuesses)) \(numGuesses > 1 ? "guesses" : "guess")")
            .font(.largeTitle).fontWeight(.semibold)

          Toggle(isOn: $isHardMode.animation()) {
            Text("Hard Mode \(isHardMode ? "ON" : "OFF")")
              .font(.body).fontWeight(.semibold)
              .padding([.leading, .trailing], 10)
          }
          .toggleStyle(.button)
          .tint(Colors.Background.Button.secondary)
          .cornerRadius(8)

          Button(action: {
            if isInputFilled {
              self.saveScore()
            } else {
              isReportingFail = true
            }
          }) {
            Text(isInputFilled || Int(numGuesses) > maxGuesses ? "Submit" : "I didn't guess correctly 😕")
              .foregroundColor(.white)
              .font(.body).fontWeight(.semibold)
              .padding()
              .background(isInputFilled ? Colors.Background.Button.primary : Colors.Background.Button.tertiary)
              .cornerRadius(8)
          }
          .alert(
            "Reporting a fail?",
            isPresented: $isReportingFail,
            actions: {
              Button("Cancel", role: .cancel, action: { isReportingFail = false })
              Button("Confirm") { self.saveScore() }
            },
            message: { Text("Respect 🤝 You'll get tomorrow's puzzle!") }
          )
          .alert(
            "Something went wrong!",
            isPresented: $isErrorState,
            actions: {
              Button("Okay", role: .cancel, action: { errorMessage = nil })
            },
            message: { Text(errorMessage ?? "") }
          )
          Spacer()
        }
        .padding(16)
      }
    }
    .navigationTitle("today's \(game.title)")
  }

  private func saveScore() {
    let score = Score(context: CoreDataStack.context)
    score.answer = answerInput.lowercased()
    score.date = Date()
    score.guessSummary = parseResult?.guessSummary
    score.isHardMode = isHardMode
    score.maxGuesses = Int64(maxGuesses)
    score.memo = parseResult?.gameMemo
    score.numberOfGuesses = Int64(numGuesses)
    score.submissionTimestamp = Date()
    score.title = parseResult?.gameTitle ?? game.title

    do {
      try CoreDataStack.saveContext()
      rootPresentationMode.wrappedValue.dismiss()
    } catch {
      #if DEBUG
      errorMessage = error.localizedDescription
      #else
      errorMessage = "There was a problem saving your score. The developer has been notified of this issue ✍️"
      #endif
    }
  }
}

struct ScoreSubmissionView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ScoreSubmissionView(
        game: Game.Defaults.wordle,
        parseResult: ParseResult.fixture
      )
    }.preferredColorScheme(.dark)
  }
}
