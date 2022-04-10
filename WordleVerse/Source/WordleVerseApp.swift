//
//  WordleVerseApp.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 2/25/22.
//

import CoreData
import SwiftUI

@main
struct WordleVerseApp: App {
  var body: some Scene {
    WindowGroup {
      HomeScreenView()
        .environment(\.managedObjectContext, CoreDataStack.context)
    }
  }
}
