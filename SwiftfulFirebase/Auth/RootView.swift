//
//  RootView.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import SwiftUI

struct RootView: View {
    @State private var showSignInView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear {
            let user = try? AuthManager.shared.getAuthenticatedUser()
            self.showSignInView = user == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationView {
                AuthView(showSignInView: $showSignInView)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
