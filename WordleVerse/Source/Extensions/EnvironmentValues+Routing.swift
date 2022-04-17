//
//  EnvironmentValues+Routing.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/2/22.
//

import Foundation
import SwiftUI

struct DidSubmitScoreKey: EnvironmentKey {
  static let defaultValue: Binding<Bool> = .constant(Bool())
}

struct RootPresentationModeKey: EnvironmentKey {
  static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
  var didSubmitScore: Binding<Bool> {
    get { return self[DidSubmitScoreKey.self] }
    set {self[DidSubmitScoreKey.self] = newValue }
  }

  var rootPresentationMode: Binding<RootPresentationMode> {
    get { return self[RootPresentationModeKey.self] }
    set { self[RootPresentationModeKey.self] = newValue }
  }
}

typealias RootPresentationMode = Bool
extension RootPresentationMode {
  public mutating func dismiss() {
    self.toggle()
  }
}
