//
//  FlexibleButton.swift
//  Recordle
//
//  Created by Nathan Fuller on 3/5/22.
//

import SwiftUI

struct FlexibleButton: ButtonStyle {
  var color: Color = .clear
  var idealHeight: CGFloat = 93

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 17).weight(.semibold))
      .foregroundColor(Colors.Text.primary)
      .homeScreenRow()
      .background(configuration.isPressed ? Color(white: 0, opacity: 0.2) : Color.clear)
      .background(Colors.Background.Gradient.bottomToTop)
      .background(color)
      .cornerRadius(8)
  }
}
