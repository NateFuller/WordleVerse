//
//  ContentView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Text("today's wordles")
        .fontWeight(.bold)
        .font(.title)
      LazyVStack(spacing: 15) {
        ForEach(Game.defaultList, id: \.self) { game in
          GameRowView(viewModel: GameRowViewModel(game: game))
            .frame(maxWidth: .infinity)
        }
        PrimaryButton("Submit Results") {}.frame(idealHeight: 93)
        SecondaryButton("History") {}.frame(idealHeight: 93)
      }
      Spacer()
    }.padding(16)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
}
