//
//  InnerShadowModifier.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/1/22.
//

import SwiftUI

struct InnerShadowModifier: ViewModifier {
  var radius: CGFloat = 15
  func body(content: Content) -> some View {
    content
      .overlay(
        RoundedRectangle(cornerRadius: radius)
          .stroke(Colors.Background.primary, lineWidth: 4)
          .shadow(color: Colors.Input.shadowPrimary, radius: 4, x: 4, y: 4)
          .clipShape(RoundedRectangle(cornerRadius: radius))
          .shadow(color: Colors.Input.shadowPrimary, radius: 4, x: -4, y: -4)
          .clipShape(RoundedRectangle(cornerRadius: radius))
        )
  }
}

struct InnerShadowModifier_Previews: PreviewProvider {
  static var previews: some View {
    Rectangle()
      .fill(Colors.Background.primary)
      .frame(height: 375)
      .cornerRadius(15)
      .modifier(InnerShadowModifier())
      .preferredColorScheme(.dark)
  }
}
