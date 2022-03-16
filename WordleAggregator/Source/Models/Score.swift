//
//  Score.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/16/22.
//

import Foundation
import CoreData

class Score: NSManagedObject, Decodable {
  enum CodingKeys: CodingKey {
    case answer
    case gameDate
    case numberOfGuesses
    case submissionTimestamp
    case win
  }

  required convenience init(from decoder: Decoder) throws {
    guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
      throw DecoderConfigurationError.missingManagedObjectContext
    }

    self.init(context: context)

    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.answer = try container.decodeIfPresent(String.self, forKey: .answer)
    self.gameDate = try container.decode(Date.self, forKey: .gameDate)
    self.numberOfGuesses = try container.decode(Int64.self, forKey: .numberOfGuesses)
    self.submissionTimestamp = try container.decode(Date.self, forKey: .submissionTimestamp)
    self.win = try container.decode(Bool.self, forKey: .win)
  }
}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
