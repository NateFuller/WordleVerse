//
//  WordleInputField.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/7/22.
//

import SwiftUI

struct WordleInputField: View {
  var length: Int = 5
  var filledTemporary: Bool = false

  @State var inputText: String = ""

  var body: some View {
    VStack() {
      ZStack {
        foregroundText
        squares
      }
    }
  }


  private var foregroundText: some View {
    TextField("", text: $inputText)
  }

  private var squares: some View {
    HStack {
      Spacer()
      ForEach(0..<length) { index in
        Rectangle()
          .fill(filledTemporary ? Colors.Background.Input.filled : Colors.Background.Input.empty)
          .border(filledTemporary ? Colors.Background.Input.filled : Colors.Input.borderEmpty, width: 2)
          .frame(width: 62, height: 62)
        Spacer()
      }
    }
  }
}

struct WordleInputField_Previews: PreviewProvider {
  static var previews: some View {
    WordleInputField()
      .preferredColorScheme(.dark)
  }
}
