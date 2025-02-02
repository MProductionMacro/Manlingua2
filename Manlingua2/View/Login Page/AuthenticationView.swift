import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore

struct AuthenticationView: View {
   @EnvironmentObject var router: Router
   @State private var email: String = ""
   @State private var password: String = ""
   @State private var name: String = ""
   @State private var errorMessage: String = ""
   @Binding var isSignIn: Bool
   
   var body: some View {
      VStack(spacing: 20) {
         Text(isSignIn ? "Sign In".localized : "Sign Up".localized)
            .font(.largeTitle)
            .bold()
         
         if !isSignIn {
            TextField("Name".localized, text: $name)
               .padding()
               .background(Color(.systemGray6))
               .cornerRadius(8)
         }
         
         TextField("Email".localized, text: $email)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
         
         SecureField("Password".localized, text: $password)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
         
         Button(action: handleEmailAuthentication) {
            Text(isSignIn ? "Sign In".localized : "Sign Up".localized)
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
            Text(isSignIn ? "Don't have an account? Sign Up".localized : "Already have an account? Sign In".localized)
         }
      }
      .padding()
      .navigationTitle(isSignIn ? "Sign In".localized : "Sign Up".localized)
   }
   
   func handleEmailAuthentication() {
      if email.isEmpty || password.isEmpty || (!isSignIn && name.isEmpty) {
         errorMessage = "Please fill in all fields.".localized
         return
      }
      if !isValidEmail(email) {
         errorMessage = "Invalid email format.".localized
         return
      }
      if password.count < 6 {
         errorMessage = "Password must be at least 6 characters.".localized
         return
      }
      
      if isSignIn {
         Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
               errorMessage = error.localizedDescription
            } else {
               errorMessage = "Signed in successfully!".localized
               router.pushReplace(.mainScreen)
//               UserDefaults.standard.set(true, forKey: "hasSignedIn")
            }
         }
      } else {
         Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
               errorMessage = error.localizedDescription
            } else {
               saveNameToFirestore()
               errorMessage = "Account created successfully!".localized
            }
         }
      }
   }
   
   func saveNameToFirestore() {
      guard let userID = Auth.auth().currentUser?.uid else { return }
      let db = Firestore.firestore()
      db.collection("users").document(userID).setData(["name": name]) { error in
         if let error = error {
            errorMessage = "Failed to save name: \(error.localizedDescription)".localized
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
