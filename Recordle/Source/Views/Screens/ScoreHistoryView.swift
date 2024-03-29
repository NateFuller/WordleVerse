//
//  ScoreHistoryView.swift
//  Recordle
//
//  Created by Nathan Fuller on 3/6/22.
//

import SwiftUI
import CoreData

struct ScoreHistoryView: View {

  @Environment(\.didSubmitScore) private var presentingScoreSubmission: Binding<Bool>

  @FetchRequest(
    entity: Score.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Score.date, ascending: false)
    ]
  ) var scores: FetchedResults<Score>

  @State private var isErrorState: Bool = false
  @State private var errorMessage: String? { didSet { isErrorState = !errorMessage.isNilOrEmpty }}

  var body: some View {
    Background {
      List {
        ForEach(scores, id: \.self) { score in
          HistoryRow(viewModel: ScoreHistoryViewModel(score: score))
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .onDelete(perform: removeScore)
        //      .swipeActions { } TODO for edit functionality?
      }
      .alert("Something went wrong", isPresented: $isErrorState, actions: {
        Button("Okay", role: .cancel, action: { errorMessage = nil })
      }, message: {
        Text(errorMessage ?? "")
      })
      .listStyle(.plain)
      .background(
        NavigationLink(destination: PasteResultsView(), isActive: presentingScoreSubmission) {
          EmptyView()
        }
      )
    }
    .navigationTitle("History")
    .toolbar(content: {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button {
          presentingScoreSubmission.wrappedValue = true
        } label: {
          Image(systemName: "plus")
        }
      }
    })
    .onAppear() {
      AnalyticsManager.logger.logScreen(.scoreHistory)
    }
  }

  // MARK: - CoreData helpers

  func removeScore(at offsets: IndexSet) {
    for index in offsets {
      let score = scores[index]
      CoreDataStack.context.delete(score)
    }

    do {
      try CoreDataStack.saveContext()
      AnalyticsManager.logger.logEvent(name: .historyRowDeleted)
    } catch {
      CoreDataStack.context.rollback()

#if DEBUG
      errorMessage = error.localizedDescription
#else
      errorMessage = "There was a problem saving your score. The developer has been notified of this issue ✍️"
#endif

      AnalyticsManager.logger.logEvent(name: .historyRowDeletionError,
                               parameters: [Event.ParameterKey.errorMessage: error.localizedDescription])
    }
  }
}

// MARK: - Previews

struct ScoreHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    let testScores = TestScores(context: CoreDataStack.context)
    try! testScores.addRows()

    return NavigationView {
      ScoreHistoryView()
        .preferredColorScheme(.dark)
        .environment(\.managedObjectContext, CoreDataStack.context)
    }
  }
}
