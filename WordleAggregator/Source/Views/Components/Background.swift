//
//  Background.swift
//  WordleAggregator
//
//  Created by Nathan Fuller on 3/14/22.
//

import SwiftUI

struct Background<Content: View>: View {
  private var content: Content

  init(@ViewBuilder content: @escaping () -> Content) {
    self.content = content()
  }

  var body: some View {
    ZStack {
      Colors.Background.primary
        .ignoresSafeArea()
      content
    }
  }
}

struct Previews_Background_Previews: PreviewProvider {
  static var previews: some View {
    Background {
      Text("Hello, World!")
    }
    .preferredColorScheme(.dark)
  }
}
