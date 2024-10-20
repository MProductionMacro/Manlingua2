//
//  AuthenticationView.swift
//  Manlingua2
//
//  Created by Paulus Michael on 18/10/24.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct AuthenticationView: View {
   @State private var email: String = ""
   @State private var password: String = ""
   @State private var errorMessage: String = ""
   @Binding var isSignIn: Bool
   
   var body: some View {
      VStack(spacing: 20) {
         Text(isSignIn ? "Sign In" : "Sign Up")
            .font(.largeTitle)
            .bold()
         
         TextField("Email", text: $email)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
         
         SecureField("Password", text: $password)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
         
         Button(action: handleEmailAuthentication) {
            Text(isSignIn ? "Sign In" : "Sign Up")
               .frame(maxWidth: .infinity)
               .padding()
               .background(Color.blue)
               .foregroundColor(.white)
               .cornerRadius(10)
         }
         .padding(.horizontal, 40)
         
         if !errorMessage.isEmpty {
            Text(errorMessage)
               .foregroundColor(.red)
               .padding()
         }
         
         Button(action: {
            isSignIn.toggle()
         }) {
            Text(isSignIn ? "Don't have an account? Sign Up" : "Already have an account? Sign In")
         }
      }
      .padding()
      .navigationTitle(isSignIn ? "Sign In" : "Sign Up")
   }
   
   func handleEmailAuthentication() {
      if email.isEmpty || password.isEmpty {
         errorMessage = "Please enter an email and password."
         return
      }
      if !isValidEmail(email) {
         errorMessage = "Invalid email format."
         return
      }
      if password.count < 6 {
         errorMessage = "Password must be at least 6 characters."
         return
      }
      
      if isSignIn {
         Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
               errorMessage = error.localizedDescription
            } else {
               errorMessage = "Signed in successfully!"
            }
         }
      } else {
         Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
               errorMessage = error.localizedDescription
            } else {
               errorMessage = "Account created successfully!"
            }
         }
      }
   }
   
   func isValidEmail(_ email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
      return emailPred.evaluate(with: email)
   }
}

#Preview {
   AuthenticationView(isSignIn: .constant(true))
}
