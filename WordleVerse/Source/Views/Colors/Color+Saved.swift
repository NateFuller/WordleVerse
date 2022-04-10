//
//  Color+Saved.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 3/4/22.
//

import SwiftUI

struct Colors {
  struct Button {
    struct Primary {
      static let background = Color("btn.primary.background")
      static let text = Color("btn.primary.text")
    }

    struct Secondary {
      static let background = Color("btn.secondary.background")
    }

    struct Tertiary {
      static let background = Color("btn.tertiary.background")
      static let text = Color("btn.tertiary.text")
    }
  }

  struct Background {
    static let primary = Color("bg.primary")
    static let secondary = Color("bg.secondary")
    static let warning = Color("bg.warning")
    static let infoHighlight = Colors.Button.Secondary.background

    struct Gradient {
      static let bottomToTop = LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .top)
      static let diagonalTopTown = LinearGradient(colors: [Color.init(white: 0, opacity: 0.2), .clear],
                                                  startPoint: UnitPoint(x: 0.49, y: 0),
                                                  endPoint: UnitPoint(x: 0.51, y: 1))
    }

    struct Input {
      static let empty = Color("bg.input.empty")
      static let filled = Color("bg.input.filled")
    }
  }

  struct Foreground {
    static let primary = Color.gray
  }

  struct Shadows {
    static let primary = Color("shadow.primary")
  }

  struct Input {
    static let borderEmpty = Color("input.border.empty")
    static let placeholder = Color("input.placeholder")
    static let shadowPrimary = Color("input.shadow.primary")
    static let shadowSecondary = Color("input.shadow.secondary")
  }

  struct Text {
    static let infoHighlight = Color("btn.secondary")
    static let link = Color("text.link")
    static let primary = Color("text.primary")
  }
}
