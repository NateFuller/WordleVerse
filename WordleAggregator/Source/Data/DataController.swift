//
//  DataController.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/6/22.
//

import Foundation

import CoreData

struct CoreDataStack {
  static var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }

  static var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "WordleVerse")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
      }
    }
    return container
  }()

  static func saveContext() throws {
    let context = CoreDataStack.persistentContainer.viewContext

    if context.hasChanges {
      try context.save()
    }
  }
}
