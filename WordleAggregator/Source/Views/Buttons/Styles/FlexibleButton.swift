//
//  FlexibleButton.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/5/22.
//

import SwiftUI

struct FlexibleButton: ButtonStyle {
  var color: Color

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.system(size: 17).weight(.semibold))
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .foregroundColor(.white)
      .background(Colors.Background.Gradient.bottomToTop)
      .background(color)
      .cornerRadius(8)
  }
}
