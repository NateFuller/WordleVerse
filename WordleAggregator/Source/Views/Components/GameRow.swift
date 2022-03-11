//
//  GameRowView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct GameRow: View {
  var viewModel: GameRowViewModel
  @Environment(\.colorScheme) var colorScheme
  @Environment(\.openURL) var openURL

  var body: some View {
    ZStack {
      Text(viewModel.title)
        .foregroundColor(.white)
        .fontWeight(.bold)
        .font(.title2)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 8))
    }
    .homeScreenRow(alignment: .bottomTrailing)
    .background(Colors.Background.Gradient.bottomToTop)
    .background(
      Image("background.game")
        .resizable()
        .aspectRatio(contentMode: .fill)
    )
    .background(Colors.Background.primary)
    .cornerRadius(8)
  }
}

struct GameRowView_Previews: PreviewProvider {
  static var previews: some View {
    let testGame = Game(context: CoreDataStack.context)
    testGame.title = Game.wordle.title
    testGame.url = URL(string: Game.wordle.url)!
    testGame.wordLength = Game.wordle.wordLength
    testGame.maxGuesses = Game.wordle.maxGuesses

    return GameRow(viewModel: GameRowViewModel(game: testGame))
      .previewLayout(.fixed(width: 358, height: 93))
  }
}
