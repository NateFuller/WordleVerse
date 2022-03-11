//
//  WordleInputField.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/7/22.
//

import SwiftUI

struct WordleInputField: View {
  var length: Int
  @Binding var inputText: String
  @FocusState private var isFocused: Bool

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
    TextField("", text: $inputText)
      .keyboardType(.alphabet)
      .disableAutocorrection(true)
      .accentColor(.clear)
      .tint(.clear)
      .foregroundColor(.clear)
      .multilineTextAlignment(.center)
      .focused($isFocused)
  }

  private var squares: some View {
    HStack() {
      ForEach(0..<length) { index in
        ZStack {
          Rectangle()
            .fill(!inputText[index].isEmpty ? Colors.Background.Input.filled : Colors.Background.Input.empty)
            .border(!inputText[index].isEmpty ? Colors.Background.Input.filled : Colors.Input.borderEmpty, width: 2)
          Text(inputText[index].uppercased())
            .font(.system(size: 500))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .minimumScaleFactor(0.01)
            .padding(80 / CGFloat(length))
        }.aspectRatio(1, contentMode: .fit)
      }
    }
  }
}

struct WordleInputField_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      WordleInputField(length: 5, inputText: .constant("weir"))
    }

  }
}
