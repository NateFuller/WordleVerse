//
//  GameSelectionView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct GameSelectionView: View {
  @FetchRequest(
    entity: Game.entity(),
    sortDescriptors: []
  ) var games: FetchedResults<Game>

  var body: some View {
    VStack(alignment: .leading) {
      Text("which game would you like to report results for?")
        .font(.title3).fontWeight(.bold)
      ScrollView {
        LazyVStack(spacing: 15) {
          ForEach(games, id: \.self) { game in
            NavigationLink(destination: ScoreSubmissionView(gameWordLength: Int(game.wordLength))) {
              GameRow(viewModel: GameRowViewModel(game: game))
            }
          }
        }
      }
      Spacer()
    }
    .padding(16)
    .navigationTitle("submit results")
  }
}

struct GameSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    GameSelectionView()
      .environment(\.managedObjectContext, CoreDataStack.context)
  }
}
