//
//  EnvironmentValues+Routing.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 4/2/22.
//

import Foundation
import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
  static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
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
