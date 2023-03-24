//
//  AuthView.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import SwiftUI
import GoogleSignInSwift

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
}

@MainActor
final class AuthViewModel: ObservableObject {
    func signInWithGoogle() async throws {
        let tokens = try await GoogleSignInHelper.signIn()
        try await AuthManager.shared.signInWithGoogle(tokens: tokens)
    }
}

struct AuthView: View {
    @StateObject private var vm = AuthViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            NavigationLink {
                SignInView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
            GoogleSignInButton {
                Task {
                    do {
                        try await vm.signInWithGoogle()
                        showSignInView = false
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AuthView(showSignInView: .constant(true))
        }
    }
}
