//
//  GameRowView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct GameRowView: View {
  var viewModel: GameRowViewModel
  @Environment(\.colorScheme) var colorScheme

  var body: some View {
    Link(destination: URL(string: viewModel.game.url)!) {
      ZStack{
        Text(viewModel.game.title)
          .foregroundColor(.white)
          .fontWeight(.bold)
          .font(.title2)
          .padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 8))
      }
      .frame(maxWidth: .infinity, minHeight: 93, idealHeight: 93, alignment: .bottomTrailing)
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
}

struct GameRowView_Previews: PreviewProvider {
  static var previews: some View {
    GameRowView(viewModel: GameRowViewModel(game: Game.wordle))
  }
}
