//
//  TesseractAxApp.swift
//  TesseractAx
//
//  Created by Axel Schmidt on 10.02.25.
//

import SwiftUI

@main
struct SofaRotatorApp: App {
    init() {
        // Force portrait orientation
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        // Disable rotation
        AppDelegate.orientationLock = .portrait
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Helper class to manage orientation lock
class AppDelegate: NSObject, UIApplicationDelegate {
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return AppDelegate.orientationLock
    }
}
