//
//  Score.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 3/16/22.
//

import Foundation
import CoreData

class Score: NSManagedObject, Decodable {
  enum CodingKeys: CodingKey {
    case answer
    case date
    case guessSummary
    case id
    case isHardMode
    case maxGuesses
    case memo
    case numberOfGuesses
    case submissionTimestamp
    case title
  }

  required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }

    self.init(context: context)

    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.answer = try container.decodeIfPresent(String.self, forKey: .answer)
    self.date = try container.decode(Date.self, forKey: .date)
    self.guessSummary = try container.decodeIfPresent(String.self, forKey: .guessSummary)
    self.isHardMode = try container.decode(Bool.self, forKey: .isHardMode)
    self.maxGuesses = try container.decode(Int64.self, forKey: .maxGuesses)
    self.memo = try container.decode(String.self, forKey: .memo)
    self.numberOfGuesses = try container.decode(Int64.self, forKey: .numberOfGuesses)
    self.submissionTimestamp = try container.decode(Date.self, forKey: .submissionTimestamp)
    self.title = try container.decode(String.self, forKey: .title)
    self.id = try container.decode(UUID.self, forKey: .id)
  }

  var success: Bool { self.numberOfGuesses <= self.maxGuesses }
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
