//
//  Color+Saved.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/4/22.
//

import SwiftUI

struct Colors {
  struct Input {
    static let borderEmpty = Color("input.border.empty")
    static let borderFilled = Colors.Background.Input.filled
  }

  struct Background {
    static let primary = Color("bg.primary")

    struct Button {
      static let primary = Color("btn.primary")
      static let secondary = Color("btn.secondary")
    }

    struct Gradient {
      static let bottomToTop = LinearGradient(colors: [.black.opacity(0.3), .clear], startPoint: .bottom, endPoint: .top)
      static let diagonalTopTown = LinearGradient(colors: [Color.init(white: 0, opacity: 0.2), .clear],
                                                  startPoint: UnitPoint(x: 0.49, y: 0),
                                                  endPoint: UnitPoint(x: 0.51, y: 1))
    }

    struct Input {
      static let empty = Color("bg.input.empty")
      static let filled = Color("bg.input.filled")
    }
  }
}
