//
//  AuthManager.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import FirebaseAuth
import Foundation
import GoogleSignIn

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthManager {
    static let shared = AuthManager()
    private init() {}
    
    @discardableResult
    func createUser(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authData = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authData.user)
    }
    
    @discardableResult
    func signIn(withEmail email: String, password: String) async throws -> AuthDataResultModel {
        let authData = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authData.user)
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws  -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        let authData = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authData.user)
    }
    
    func signIn(cred: AuthCredential) async throws  -> AuthDataResultModel {
        let authData = try await Auth.auth().signIn(with: cred)
        return AuthDataResultModel(user: authData.user)
    }
}
