//
//  LoginView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/10/24.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct LoginView: View {
   @State private var showAuthenticationView = false
   @State private var isSignIn = true
   
   var body: some View {
      VStack {
         Spacer()
         
         Text("Selamat datang")
            .font(.judulBesar())
            .fontWeight(.bold)
            .foregroundColor(.black)
            .multilineTextAlignment(.center)
            .padding(.bottom, UIScreen.main.bounds.height * 0.02)
         
         VStack(spacing: UIScreen.main.bounds.height * 0.02) {
            SignInWithAppleButton(.signIn, onRequest: { request in
               request.requestedScopes = [.email, .fullName]
            }, onCompletion: handleSignInWithApple)
            .signInWithAppleButtonStyle(.black)
            //            .frame(height: 50)
            .frame(height: UIScreen.main.bounds.height * 0.06)
            .cornerRadius(10)
            .padding(.horizontal, UIScreen.main.bounds.width * 0.15)
            
            Button(action: {
               showAuthenticationView = true
            }) {
               HStack {
                  Image(systemName: "envelope.fill")
                  Text("Sign in with Email")
                     .font(.judulBiasa())
               }
               .frame(maxWidth: .infinity)
               .padding(UIScreen.main.bounds.height * 0.015)
               .background(Color.white)
               .foregroundColor(.black)
               .clipShape(RoundedRectangle(cornerRadius: 10))
               .overlay{
                  RoundedRectangle(cornerRadius: 10).stroke(.black, lineWidth: 1)
               }
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.15)
            .sheet(isPresented: $showAuthenticationView) {
               AuthenticationView(isSignIn: $isSignIn)
            }
         }
         
         Spacer()
         
         Text("By logging in, you agree to the")
            .font(.footnote)
            .foregroundColor(.black)
         
         HStack(spacing: 4) {
            Text("Privacy Policy")
               .foregroundColor(.blue)
               .underline()
            Text("and")
            Text("Terms and Conditions.")
               .foregroundColor(.blue)
               .underline()
         }
         .font(.footnote)
         .padding(.bottom, 20)
      }
      .background(
         Image(.backgroundPattern)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
      )
   }
   
   func handleSignInWithApple(result: Result<ASAuthorization, Error>) {
      switch result {
      case .success(let authorization):
         if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            let fullName = appleIDCredential.fullName
            
            print("User Identifier: \(userIdentifier)")
            if let email = email {
               print("Email: \(email)")
            }
            if let fullName = fullName {
               print("Full Name: \(fullName)")
            }
         }
      case .failure(let error):
         print("Error signing in with Apple: \(error.localizedDescription)")
      }
   }
}

#Preview {
   LoginView()
}
