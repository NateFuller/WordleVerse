//
//  WordleAggregatorApp.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import CoreData
import SwiftUI

@main
struct WordleAggregatorApp: App {
  var body: some Scene {
    WindowGroup {
      HomeScreenView()
        .environment(\.managedObjectContext, CoreDataStack.context)
    }
  }
}
