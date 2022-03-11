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

struct HomeScreenRow: ViewModifier {
  var idealHeight: CGFloat
  var alignment: Alignment

  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, idealHeight: idealHeight, maxHeight: .infinity, alignment: alignment)
  }
}

extension View {
  func homeScreenRow(idealHeight: CGFloat = 93, alignment: Alignment = .center) -> some View {
    modifier(HomeScreenRow(idealHeight: idealHeight, alignment: alignment))
  }
}
