//
//  SignInView.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import SwiftUI

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signUp() async throws {
        guard !email.isEmpty,
              !password.isEmpty else { return }
        try await AuthManager.shared.createUser(withEmail: email, password: password)
    }
    
    func signIn() async throws {
        guard !email.isEmpty,
              !password.isEmpty else { return }
        try await AuthManager.shared.signIn(withEmail: email, password: password)
    }
}

struct SignInView: View {
    @StateObject private var vm = SignInViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            TextField("Email", text: $vm.email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .autocorrectionDisabled()
            
            SecureField("Password", text: $vm.password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        try await vm.signUp()
                        showSignInView = false
                        return
                    } catch {
                        print("Error: \(error)")
                    }
                    
                    do {
                        try await vm.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print("Error: \(error)")
                    }
                }
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView(showSignInView: .constant(true))
        }
    }
}
