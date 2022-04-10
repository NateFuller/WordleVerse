//
//  String+Optional.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/1/22.
//

import Foundation

extension Optional where Wrapped: StringProtocol {
  var isNilOrEmpty: Bool {
    return ((self as? String) ?? "").isEmpty
  }
}
