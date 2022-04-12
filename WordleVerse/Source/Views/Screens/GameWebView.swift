//
//  GameWebView.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/9/22.
//

import SwiftUI

struct GameWebView: View {
  var game: GameRowViewModel

  var body: some View {
    WebView(url: game.url)
      .onAppear() {
        AnalyticsManager.logger.logScreen(.game(title: game.title, url: game.url.absoluteString))
      }
  }
}

struct GameWebView_Previews: PreviewProvider {
  static var previews: some View {

    GameWebView(game: GameRowViewModel(game: Game.Defaults.wordle))
        .preferredColorScheme(.dark)
    }

}
