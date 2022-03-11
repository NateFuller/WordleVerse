//
//  ScoreHistoryView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct ScoreHistoryView: View {
  var body: some View {
    List {
      Text("hi")
      Text("hi again")
    }.navigationTitle("score history")
  }
}

struct ScoreHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    ScoreHistoryView()
      .environment(\.managedObjectContext, CoreDataStack.context)
  }
}
