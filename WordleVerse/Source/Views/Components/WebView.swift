//
//  WebView.swift
//  WordleVerse
//
//  Created by Nathan Fuller on 4/9/22.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  var url: URL

  func makeUIView(context: Context) -> some UIView {
    return WKWebView()
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    guard let webView = uiView as? WKWebView else { fatalError("Error displaying WebView.") }

    let request = URLRequest(url: url)
    webView.load(request)
  }
}
