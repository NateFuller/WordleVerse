//
//  RecordleApp.swift
//  Recordle
//
//  Created by Nathan Fuller on 2/25/22.
//

import CoreData
import Firebase
import SwiftUI
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct RecordleApp: App {

  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
    WindowGroup {
      HomeScreenView()
        .environment(\.managedObjectContext, CoreDataStack.context)
    }
  }
}
