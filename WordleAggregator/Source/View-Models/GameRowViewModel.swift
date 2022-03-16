//
//  GameRowViewModel.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import Foundation
import SwiftUI

struct GameRowViewModel {
  var title: String!
  var url: URL!

  init(game: Game) {
    title = game.title
    url = URL(string: game.url)
  }
}
