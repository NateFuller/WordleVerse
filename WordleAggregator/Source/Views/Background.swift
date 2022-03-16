//
//  Background.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/14/22.
//

import SwiftUI

struct Background<Content: View>: View {
  private var content: Content

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  var body: some View {
    Color.clear
      .frame(width: UIScreen.main.bounds.width,
             height: UIScreen.main.bounds.height)
      .overlay(content)
  }

  private func endEditing() {
    UIApplication.shared.endEditing()
  }
}

struct KeyboardDismissListenerView_Previews: PreviewProvider {
  static var previews: some View {
    Background {
      ScoreSubmissionView(game: Game.Defaults.wordle2)
    }
  }
}

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder),
               to: nil,
               from: nil,
               for: nil)
  }
}
