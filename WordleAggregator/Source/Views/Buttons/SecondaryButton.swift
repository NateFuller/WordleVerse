//
//  SecondaryButton.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/4/22.
//

import SwiftUI

struct SecondaryButton: View {
  var title: String
  var action: () -> Void
  var cornerRadius: CGFloat

  init(_ title: String, cornerRadius: CGFloat = 8, action: @escaping () -> Void) {
    self.action = action
    self.title = title
    self.cornerRadius = cornerRadius
  }

  var body: some View {
    Button(title) {

    }.buttonStyle(FlexibleButton(color: Colors.Background.Button.secondary))
  }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
      SecondaryButton("History", action: {})
      .previewLayout(.fixed(width: 375, height: 93))
    }
}
