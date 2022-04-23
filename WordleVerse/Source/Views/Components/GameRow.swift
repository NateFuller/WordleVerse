//
//  GameRowView.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct GameRow: View {
  var viewModel: GameRowViewModel

  @State private var showURL = false

  var body: some View {
    Button(action: { showURL.toggle() }) {
      ZStack {
        Text(viewModel.title)
          .foregroundColor(Colors.Text.primary)
          .fontWeight(.bold)
          .font(.title2)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 8))
      }
      .homeScreenRow(idealHeight: 265, alignment: .bottomTrailing)
      .background(Colors.Background.Gradient.bottomToTop)
      .background(
        Image("background.game")
          .resizable()
          .aspectRatio(contentMode: .fill)
      )
      .background(Colors.Background.secondary)
      .cornerRadius(8)
    }
    .disabled(viewModel.enabled)
    .sheet(isPresented: $showURL) {
      GameWebView(game: viewModel)
    }
  }
}

struct GameRow_Previews: PreviewProvider {
  static var previews: some View {
    let testGame = Game.Defaults.wordle

    return GameRow(viewModel: GameRowViewModel(game: testGame))
      .previewLayout(.fixed(width: 358, height: 200))
  }
}
