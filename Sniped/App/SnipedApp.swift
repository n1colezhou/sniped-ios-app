//
//  SnipedApp.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//

import SwiftUI
import Firebase

@main
struct SnipedApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
