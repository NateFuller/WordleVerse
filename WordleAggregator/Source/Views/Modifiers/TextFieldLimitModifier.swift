//
//  TextFieldLimitModifier.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/15/22.
//
// Copy pasta'd from Martin Albrecht's
// https://sanzaru84.medium.com/swiftui-an-updated-approach-to-limit-the-amount-of-characters-in-a-textfield-view-984c942a156

import SwiftUI
import Combine

struct TextFieldLimitModifer: ViewModifier {
  @Binding var value: String
  var length: Int

  func body(content: Content) -> some View {
    content
      .onReceive(value.publisher.collect()) {
        value = String($0.prefix(length))
      }
  }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
