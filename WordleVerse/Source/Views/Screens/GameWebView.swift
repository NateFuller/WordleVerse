//
//  GameWebView.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/9/22.
//

import SwiftUI

struct GameWebView: View {
  var game: Game

  var body: some View {
    Background {
      VStack {
        WebView(url: URL(string: game.url)!)
        Spacer()
      }
    }
    .navigationBarTitle("Play \(game.title)")
    .navigationBarHidden(true)
    .onAppear() {
      FirebaseManager.logScreen(.game(title: game.title, url: game.url))
    }
  }
}

struct GameWebView_Previews: PreviewProvider {
  static var previews: some View {

      GameWebView(game: Game.Defaults.wordle)
        .preferredColorScheme(.dark)
    }

}
