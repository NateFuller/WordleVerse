//
//  ScoreSubmissionView.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct ScoreSubmissionView: View {
  var game: Game
  @State var parseResult: ParseResult

  @Environment(\.didSubmitScore) private var presentingFromHistory: Binding<Bool>
  @Environment(\.presentHistory) private var presentHistory
  @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

  @State private var answerInput: String = ""
  @State private var errorMessage: String? { didSet { isErrorState = !errorMessage.isNilOrEmpty }}
  @State private var isAnswerInfoAlertVisible: Bool = false
  @State private var isErrorState: Bool = false
  @State private var isReportingMiss: Bool = false
  @State private var sliderValue: Double

  private var isInputFilled: Bool { answerInput.length == game.answerLength }
  private var isSuccess: Bool { isInputFilled && withinMaxGuesses }
  private var maxGuesses: Int { parseResult.maxGuesses }
  private var withinMaxGuesses: Bool { parseResult.numGuesses <= maxGuesses }

  init(game: Game, parseResult: ParseResult) {
    self.game = game
    self.parseResult = parseResult
    sliderValue = Double(parseResult.numGuesses)
  }

  var body: some View {
    Background {
      ScrollView {
        VStack(spacing: 16) {
          HStack {
            Text("what was today's word?")
              .font(.title3).fontWeight(.bold)
              .frame(alignment: .leading)
            Button(action: {
              AnalyticsManager.logger.logEvent(name: .scoreSubmissionInfoDisclosureTapped)
              isAnswerInfoAlertVisible = true
            }) {
              Image(systemName: "info.circle")
                .foregroundColor(Colors.Text.link)
            }
            .alert(isPresented: $isAnswerInfoAlertVisible) {
              Alert(title: Text("What's the word?"),
                    message: Text("If you missed today's word, just leave this blank!"),
                    dismissButton: .cancel(Text("Okay")))
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

          Slider(value: Binding<Double>(
            get: { $sliderValue.wrappedValue },
            set: {
              sliderValue = $0
              parseResult.numGuesses = Int($0)
              AnalyticsManager.logger.logEvent(name: .scoreSubmissionGuessesUpdated)
            }
          ), in: 1...(Double(maxGuesses) + 1), step: 1)
            .tint(withinMaxGuesses ? Colors.Button.Primary.background : Colors.Background.warning)

          if withinMaxGuesses {
            Text("\(Int(sliderValue)) \(Int(sliderValue) > 1 ? "guesses" : "guess")")
              .font(.largeTitle).fontWeight(.semibold)
          } else {
            Text("X guesses")
              .font(.largeTitle).fontWeight(.semibold)
          }

          Toggle(isOn: $parseResult.isHardMode.animation()) {
            Text("Hard Mode \(parseResult.isHardMode ? "ON" : "OFF")")
              .font(.body).fontWeight(.semibold)
              .padding([.leading, .trailing], 10)
          }
          .toggleStyle(.button)
          .tint(Colors.Button.Secondary.background)
          .cornerRadius(8)
          .onChange(of: parseResult.isHardMode) { _ in
            AnalyticsManager.logger.logEvent(name: .scoreSubmissionHardModeUpdated)
          }

          Button(action: {
            if isSuccess {
              saveScore()
            } else {
              isReportingMiss = true
            }
          }) {
            Text(isSuccess ? "Submit" : "I didn't guess correctly 😕")
              .foregroundColor(isSuccess ? Colors.Button.Primary.text : Colors.Button.Tertiary.text)
              .font(.body).fontWeight(.semibold)
              .padding()
              .background(content: {
                if !isInputFilled {
                  Colors.Button.Tertiary.background
                } else {
                  isSuccess ? Colors.Button.Primary.background : Colors.Background.warning
                }
              })
              .cornerRadius(8)
          }
          .alert(
            "Reporting a miss?",
            isPresented: $isReportingMiss,
            actions: {
              Button("Confirm") { saveScore() }.keyboardShortcut(.defaultAction)
              Button("Cancel", role: .cancel, action: { isReportingMiss = false })
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
    .onAppear() {
      AnalyticsManager.logger.logScreen(.scoreSubmission)
    }
  }

  private func saveScore() {
    let score = Score(context: CoreDataStack.context)
    score.answer = isInputFilled ? answerInput.lowercased() : nil
    score.date = Date()
    score.guessSummary = parseResult.guessSummary
    score.isHardMode = parseResult.isHardMode
    score.maxGuesses = Int64(maxGuesses)
    score.memo = parseResult.gameMemo
    score.numberOfGuesses = Int64(parseResult.numGuesses)
    score.submissionTimestamp = Date()
    score.title = parseResult.gameTitle

    do {
      try CoreDataStack.saveContext()
      AnalyticsManager.logger.logEvent(name: .scoreSubmitted)
      if presentingFromHistory.wrappedValue {
        presentingFromHistory.wrappedValue.dismiss()
      } else {
        rootPresentationMode.wrappedValue.dismiss()
        presentHistory.wrappedValue.toggle()
      }
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
    }.preferredColorScheme(.light)
  }
}
