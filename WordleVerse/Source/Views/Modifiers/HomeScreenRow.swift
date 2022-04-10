//
//  HomeScreenRow.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/2/22.
//

import SwiftUI

struct HomeScreenRow: ViewModifier {
  var idealHeight: CGFloat
  var alignment: Alignment

  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, idealHeight: idealHeight, maxHeight: .infinity, alignment: alignment)
  }
}
