//
//  TestError.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/2/22.
//

import Foundation

enum TestError: Error {
  case runtimeError
}

extension TestError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .runtimeError: return String(localized: "Testing... Testing...")
    }
  }
}
