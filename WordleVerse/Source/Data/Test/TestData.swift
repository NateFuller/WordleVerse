//
//  TestData.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/3/22.
//

import CoreData

protocol TestProtocol {
  var context: NSManagedObjectContext { get }
  var entityName: String { get }
  func addRows() throws
  func getRows() throws -> [Any]?
}

class TestData: TestProtocol {
  var context: NSManagedObjectContext
  var entityName: String

  init(context: NSManagedObjectContext, entityName: String) {
    self.context = context
    self.entityName = entityName
  }

  func getRows() throws -> [Any]? {
    try! addRows()
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
    return try? context.fetch(fetchRequest)
  }

  func getRows<T>(count: Int) throws -> [T] {
    let fullList: [T] = try self.getRows() as! [T]
    return Array(fullList.prefix(count))
  }

  func addRows() throws {
    throw TestError.runtimeError
  }

  func noRowsExist() -> Bool {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
    let count = try! context.count(for: fetchRequest)

    return count == 0
  }
}
