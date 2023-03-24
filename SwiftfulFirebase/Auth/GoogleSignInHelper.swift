//
//  GoogleSignInHelper.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 24/03/2023.
//

import GoogleSignIn
import GoogleSignInSwift

enum GoogleSignInHelper {
    @MainActor
    static func signIn() async throws -> GoogleSignInResultModel {
        guard let controller = Utility.instance.topViewController() else {
            throw URLError(.cannotFindHost)
        }
        let gidSignResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: controller)
        guard let idToken = gidSignResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignResult.user.accessToken.tokenString
//        gidSignResult.user.profile?.name
        return GoogleSignInResultModel(idToken: idToken, accessToken: accessToken)
    }
}
