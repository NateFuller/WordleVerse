//
//  WordleInputField.swift
//  Recordle
//
//  Created by Nathan Fuller on 3/7/22.
//

import SwiftUI

struct WordleInputField: View {

  // MARK: - Public Properties

  let length: Int
  @Binding var inputText: String

  // MARK: - Private Properties

  @FocusState private var isFocused: Bool

  private var squareSpacing: CGFloat? { UIDevice.current.userInterfaceIdiom == .pad ? 20 : 8 }
  private var indexOfFocusedCharacter: Int { max(min(inputText.length, length - 1), 0) }

  init(length: Int, inputText: Binding<String>) {
    self.length = length
    self._inputText = inputText
    isFocused = false
  }

  var body: some View {
    ZStack {
      functionalButHiddenTextField
      squares.gesture(
        TapGesture()
          .onEnded({ _ in
            isFocused = true
          })
      )
    }
  }

  private var functionalButHiddenTextField: some View {
    TextField(inputText, text: $inputText)
      .limitInputLength(value: $inputText, length: length)
      .keyboardType(.alphabet)
      .disableAutocorrection(true)
      .accentColor(.clear)
      .tint(.clear)
      .foregroundColor(.clear)
      .multilineTextAlignment(.center)
      .focused($isFocused)
      .submitLabel(.done)
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          Button("Done") {
            isFocused = false
          }
        }
      }
  }

  private var squares: some View {
    HStack(spacing: squareSpacing) {
      ForEach(0..<length, id:\.self) { index in
        ZStack {
          Rectangle()
            .fill(!inputText[index].isEmpty ? Colors.Background.Input.filled : Colors.Background.Input.empty)
            .border(!inputText[index].isEmpty ? Colors.Background.Input.filled : Colors.Input.borderEmpty, width: 2)
          Text(inputText[index].uppercased())
            .font(.system(size: 500))
            .foregroundColor(Colors.Text.primary)
            .fontWeight(.bold)
            .minimumScaleFactor(0.01)
            .padding(80 / CGFloat(length))
        }
        .aspectRatio(1, contentMode: .fit)
        .frame(idealWidth: 120, maxWidth: 120)
        .scaleEffect(isFocused && index == indexOfFocusedCharacter ? 1.05 : 1)
      }
    }
  }
}

struct WordleInputField_Previews: PreviewProvider {
  static var previews: some View {
    WordleInputField(length: 5, inputText: .constant("weir"))
      .preferredColorScheme(.light)
  }
}
