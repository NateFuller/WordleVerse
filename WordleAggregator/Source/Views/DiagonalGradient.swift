//
//  DiagonalGradient.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/5/22.
//

import SwiftUI

struct DiagonalGradientShim: View {
  var body: some View {
    LinearGradient(colors: [Color.init(white: 0, opacity: 0.2), .clear],
                   startPoint: UnitPoint(x: 0.49, y: 0),
                   endPoint: UnitPoint(x: 0.51, y: 1))
  }
}

struct DiagonalGradientShim_Previews: PreviewProvider {
    static var previews: some View {
      DiagonalGradientShim()
      .previewLayout(.fixed(width: 375, height: 93))
    }
}
