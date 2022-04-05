//
//  PasteResultsView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/1/22.
//

import SwiftUI

struct PasteResultsView: View {
  var game: Game = Game.Defaults.wordle

  @State var inputText: String = ""
  @State private var validResultParsed: Bool = false
  @State private var currentParseResult: ParseResult?
  @State private var isErrorState: Bool = false
  @State private var errorMessage: String? {
    didSet { isErrorState = !errorMessage.isNilOrEmpty }
  }

  var body: some View {
    Background {
      VStack {
        WordleResultInputField(userInput: $inputText)
          .frame(height: 180)

        NavigationLink(
          destination: ScoreSubmissionView(game: Game.Defaults.wordle,
                                           parseResult: currentParseResult),
          isActive: $validResultParsed
        ) {
          EmptyView()
        }
        .isDetailLink(false)

        Button(action: {
          do {
            currentParseResult = try WordleParser.parse(resultText: inputText)
            validResultParsed = true
          } catch {
            errorMessage = error.localizedDescription
          }
        }) {
          Text(inputText.isEmpty ? "Paste your \"Share\" text above!" : "Let's go 😤")
            .foregroundColor(.white)
            .font(.body).fontWeight(.semibold)
            .padding()
            .background(inputText.isEmpty ? Colors.Background.Button.tertiary : Colors.Background.Button.primary)
            .cornerRadius(8)
        }
        .disabled(inputText.isEmpty)
        .alert(Text("Awww dangit 😞"), isPresented: $isErrorState, actions: {
          Button("Okay!", role: .cancel, action: {})
        }, message: {
          Text(errorMessage ?? "")
        })

        Button(action: { validResultParsed = true }) {
          Text("Skip this step")
            .underline()
        }
        .foregroundColor(Colors.Text.link)
        .padding()

        Spacer()
      }
    }
    .navigationTitle("Submit your score 📋")
    .onAppear { validResultParsed = false }
  }
}

struct PasteResultsView_Previews: PreviewProvider {
  static var previews: some View {
//    NavigationView {
      PasteResultsView()
        .preferredColorScheme(.dark)
//    }
  }
}
