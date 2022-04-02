//
//  ScoreHistoryView.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI

struct ScoreHistoryView: View {

  @FetchRequest(
    entity: Score.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Score.date, ascending: true)
    ]
  ) var scores: FetchedResults<Score>

  @State private var isErrorState: Bool = false
  @State private var errorMessage: String? { didSet { isErrorState = !errorMessage.isNilOrEmpty }}

  var body: some View {
    List {
      ForEach(scores, id: \.self) { score in
        HStack {
          Text(score.title ?? "")
          Text(score.answer ?? "")
          Text("\(score.numberOfGuesses)/\(score.maxGuesses)")
        }
      }
      .onDelete(perform: removeScore)
    }
    .alert("Something went wrong", isPresented: $isErrorState, actions: {
      Button("Okay", role: .cancel, action: { errorMessage = nil })
    }, message: {
      Text(errorMessage ?? "")
    })
    .listRowSeparator(.hidden)
    .navigationTitle("score history")
  }

  func removeScore(at offsets: IndexSet) {
    for index in offsets {
      let score = scores[index]
      CoreDataStack.context.delete(score)
    }

    do {
      try CoreDataStack.saveContext()
    } catch {
      CoreDataStack.context.rollback()

#if DEBUG
      errorMessage = error.localizedDescription
#else
      errorMessage = "There was a problem saving your score. The developer has been notified of this issue ✍️"
#endif
    }
  }
}

struct ScoreHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    ScoreHistoryView()
      .environment(\.managedObjectContext, CoreDataStack.context)
  }
}
