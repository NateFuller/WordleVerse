//
//  GameRowViewModel.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 2/25/22.
//

import Foundation
import SwiftUI

struct GameRowViewModel {
  var title: String!
  var url: URL!
  var enabled: Bool

  init(game: Game) {
    enabled = game.enabled
    title = game.title
    url = URL(string: game.url)
  }
}
