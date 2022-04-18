//
//  WordleResultInputField.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 3/22/22.
//

import SwiftUI

struct WordleResultInputField: View {
  @Binding var userInput: String

  init(userInput: Binding<String>) {
    self._userInput = userInput

    /* Override TextEditor background to allow for setting a custom background in SwiftUI */
    UITextView.appearance().backgroundColor = .clear
  }

  var body: some View {
    ZStack(alignment: .leading) {
      if (userInput.isEmpty) {
        VStack {
          Text("Paste your results here")
            .foregroundColor(Colors.Input.placeholder)
            .padding()
          Spacer()
        }
      }
      TextEditor(text: $userInput)
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 0))
        .opacity(userInput.isEmpty ? 0.7 : 1)
    }
    .background(Colors.Background.primary)
    .cornerRadius(15)
    .innerShadow()
    .padding()
  }
}

struct WordleResultInputField_Previews: PreviewProvider {
  static var previews: some View {
    Background {
      WordleResultInputField(userInput: .constant(""))
        .preferredColorScheme(.dark)
    }
  }
}
