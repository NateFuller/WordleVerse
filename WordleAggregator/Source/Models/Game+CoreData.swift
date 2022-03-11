//
//  Game+CoreData.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 2/25/22.
//

import Foundation
import CoreData

extension Game {
  static let defaultList = [wordle, wordle2]
  static let wordle = (title: "Wordle",
                       url: "https://www.nytimes.com/games/wordle/index.html",
                       wordLength: Int16(5),
                       maxGuesses: Int16(6))
  static let wordle2 = (title: "Wordle2",
                        url: "https://www.wordle2.in/",
                        wordLength: Int16(6),
                        maxGuesses: Int16(6))

  static func addGame(title: String, url: String, wordLength: Int16, maxGuesses: Int16) {
    let newGame = Game(context: CoreDataStack.context)

    newGame.title = title
    newGame.url = URL(string: url)
    newGame.wordLength = wordLength
    newGame.maxGuesses = maxGuesses

    CoreDataStack.saveContext()
  }

  static func addDefaultGames() {
    let storedGameCount = Game.countOnStorage
    guard storedGameCount != Game.defaultList.count else { return }

    let context = CoreDataStack.context
    if storedGameCount > 0 {
      let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Game.fetchRequest()
      let clearRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

      do {
        try context.execute(clearRequest)
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }

    for game in Game.defaultList {
      Game.addGame(title: game.title,
                   url: game.url,
                   wordLength: game.wordLength,
                   maxGuesses: game.maxGuesses)
    }
  }

  static var countOnStorage: Int {
    let context = CoreDataStack.context
    let gamesRequest: NSFetchRequest<NSFetchRequestResult> = Game.fetchRequest()
    do {
      return try context.count(for: gamesRequest)
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
}
