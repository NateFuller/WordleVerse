//
//  Color+Saved.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/4/22.
//

import CoreGraphics
import SwiftUI

struct Colors {
  struct Background {
    static let primary = Color("bg.primary")

    struct Button {
      static let primary = Color("btn.primary")
      static let secondary = Color("btn.secondary")
    }

    struct Gradient {
      static let bottomToTop = LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
    }
  }
}
