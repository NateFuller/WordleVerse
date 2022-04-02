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
    VStack {
      WordleResultInputField(userInput: $inputText)
        .frame(height: 180)
      NavigationLink(destination: ScoreSubmissionView(game: Game.Defaults.wordle,
                                                      parseResult: currentParseResult),
                     isActive: $validResultParsed) {
        EmptyView()
      }
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
      .alert(isPresented: $isErrorState) {
        Alert(title: Text("Awww dangit 😞"),
              message: Text(errorMessage!),
              dismissButton: .cancel(Text("Okay!"), action: {

        }))

      }
      Spacer()
    }
    .navigationTitle("Submit your score 📋")
    .onAppear { validResultParsed = false }
  }
}

struct PasteResultsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      PasteResultsView()
        .preferredColorScheme(.dark)
    }
  }
}
