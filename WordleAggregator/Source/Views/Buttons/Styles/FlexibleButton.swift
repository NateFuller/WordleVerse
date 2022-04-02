//
//  FlexibleButton.swift
//  WordleAggregator
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
      .foregroundColor(.white)
      .homeScreenRow()
      .background(Colors.Background.Gradient.bottomToTop)
      .background(color)
      .cornerRadius(8)
      .scaleEffect(configuration.isPressed ? 0.98 : 1)
      .animation(.easeInOut, value: configuration.isPressed)
  }
}
