//
//  HomeScreenView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct HomeScreenView: View {
  let games = Game.Defaults.all

  var body: some View {
    NavigationView {
      Background {
        VStack(alignment: .leading) {
          ScrollView {
            LazyVStack(spacing: 15) {

              // Links to games
              ForEach(games.filter { $0.enabled }, id: \.self) { game in
                let viewModel = GameRowViewModel(game: game)
                Link(destination: viewModel.url) {
                  GameRow(viewModel: viewModel)
                }
              }
              NavigationLink(destination: PasteResultsView()) {
                Text("Submit Results")
              }.buttonStyle(FlexibleButton(color: Colors.Background.Button.primary))
              NavigationLink(destination: ScoreHistoryView()) {
                Text("History")
              }.buttonStyle(FlexibleButton(color: Colors.Background.Button.secondary))
            }
          }
          Spacer()
        }
        .navigationTitle("glhf 😊")
        .padding(16)
      }
    }
  }
}

struct HomeScreenView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreenView()
      .preferredColorScheme(.light)
      .environment(\.managedObjectContext, CoreDataStack.context)
  }
}
