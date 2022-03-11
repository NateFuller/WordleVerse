//
//  HomeScreenView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct HomeScreenView: View {

  @FetchRequest(
    entity: Game.entity(),
    sortDescriptors: []
  ) var games: FetchedResults<Game>

  var body: some View {
    NavigationView {
      VStack(alignment: .leading) {
        ScrollView {
          LazyVStack(spacing: 15) {
            ForEach(games, id: \.self) { game in
              let viewModel = GameRowViewModel(game: game)
              Link(destination: viewModel.url) {
                GameRow(viewModel: viewModel)
              }
            }
            NavigationLink(destination: GameSelectionView()) {
              Text("Submit Results")
            }.buttonStyle(FlexibleButton(color: Colors.Background.Button.primary))
            NavigationLink(destination: ScoreHistoryView()) {
              Text("History")
            }.buttonStyle(FlexibleButton(color: Colors.Background.Button.secondary))
          }
        }
        Spacer()
      }
      .navigationTitle("today's wordles")
      .padding(16)
    }
  }
}

struct HomeScreenView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreenView()
      .environment(\.managedObjectContext, CoreDataStack.context)
  }
}
