//
//  SettingsView.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func logout() throws {
        try AuthManager.shared.logout()
    }
}

struct SettingsView: View {
    @StateObject private var vm = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            Button("Log out") {
                do {
                    try vm.logout()
                    showSignInView = true
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSignInView: .constant(false))
    }
}
