//
//  View+HomeScreenRow.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/2/22.
//

import SwiftUI

extension View {
  func homeScreenRow(idealHeight: CGFloat = 93, alignment: Alignment = .center) -> some View {
    modifier(HomeScreenRow(idealHeight: idealHeight, alignment: alignment))
  }
}
