//
//  HomeScreenView.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct HomeScreenView: View {
  @State var historyIsRoot: Bool = false
  @State var presentingScoreSubmission: Bool = false
  @State var presentingHistory: Bool = false
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
                GameRow(viewModel: viewModel)
              }

              // Submit Button
              NavigationLink(
                destination: PasteResultsView(),
                isActive: $presentingScoreSubmission
              ) {
                Text("Submit Results")
              }
              .isDetailLink(false)
              .buttonStyle(FlexibleButton(color: Colors.Button.Primary.background))

              // History Button
              NavigationLink(destination: ScoreHistoryView(),
                             isActive: $presentingHistory) {
                Text("History")
              }
              .buttonStyle(FlexibleButton(color: Colors.Button.Secondary.background))
            }
          }
          Spacer()
        }
        .navigationTitle(Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String)
        .padding(16)
      }
      .onAppear() {
        AnalyticsManager.logger.logScreen(.home)
      }
    }
    .accentColor(Colors.Text.link)
    .navigationViewStyle(.stack)
    .environment(\.didSubmitScore, $historyIsRoot)
    .environment(\.presentHistory, $presentingHistory)
    .environment(\.rootPresentationMode, $presentingScoreSubmission)
  }
}

struct HomeScreenView_Previews: PreviewProvider {
  static var previews: some View {
    HomeScreenView()
      .preferredColorScheme(.light)
      .environment(\.managedObjectContext, CoreDataStack.context)
  }
}
