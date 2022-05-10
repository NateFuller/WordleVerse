//
//  EnvironmentValues+Routing.swift
//  Recordle
//
//  Created by Nathan Fuller on 4/2/22.
//

import Foundation
import SwiftUI

// MARK: - Navigation Flow Roots

struct DidSubmitScoreKey: EnvironmentKey {
  static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

struct RootPresentationModeKey: EnvironmentKey {
  static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

// MARK: - Presentable

struct PresentHistoryKey: EnvironmentKey {
  static let defaultValue: Binding<Bool> = .constant(Bool())
}

extension EnvironmentValues {
  var didSubmitScore: Binding<RootPresentationMode> {
    get { return self[DidSubmitScoreKey.self] }
    set {self[DidSubmitScoreKey.self] = newValue }
  }

  var rootPresentationMode: Binding<RootPresentationMode> {
    get { return self[RootPresentationModeKey.self] }
    set { self[RootPresentationModeKey.self] = newValue }
  }

  var presentHistory: Binding<Bool> {
    get { return self[PresentHistoryKey.self] }
    set { self[PresentHistoryKey.self] = newValue }
  }
}

typealias RootPresentationMode = Bool
extension RootPresentationMode {
  public mutating func dismiss() {
    self.toggle()
  }
}
