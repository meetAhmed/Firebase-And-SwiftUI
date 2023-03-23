//
//  SwiftfulFirebaseApp.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import Firebase
import SwiftUI

@main
struct SwiftfulFirebaseApp: App {
    init() {
        FirebaseApp.configure()
        print("Firebase configured")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
