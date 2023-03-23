//
//  AuthView.swift
//  SwiftfulFirebase
//
//  Created by Ahmed Ali on 23/03/2023.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        VStack {
            NavigationLink {
                SignInView()
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .navigationTitle("Sign In")
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AuthView()
        }
    }
}
