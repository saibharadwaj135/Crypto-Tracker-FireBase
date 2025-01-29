//
//  Crypto_Tracker_FireBaseApp.swift
//  Crypto Tracker FireBase
//
//  Created by Sai bharadwaj Adapa on 1/23/25.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Crypto_Tracker_FireBaseApp: App {
    
    // register app delegate for Firebase setup
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
