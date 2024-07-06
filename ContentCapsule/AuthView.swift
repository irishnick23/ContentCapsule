import SwiftUI
import FirebaseAuth

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @State private var isSignUp = false
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn = false

    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: DesignSystem.standardPadding) {
                    Text(isSignUp ? "Sign Up" : "Sign In")
                        .font(DesignSystem.titleFont)
                        .foregroundColor(DesignSystem.textColor)
                    
                    CustomTextField(placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    
                    CustomTextField(placeholder: "Password", text: $password)
                        .textContentType(isSignUp ? .newPassword : .password)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(DesignSystem.accentColor)
                            .font(DesignSystem.bodyFont)
                    }
                    
                    DesignSystem.ButtonStyle.primaryButton(title: isSignUp ? "Sign Up" : "Sign In", action: isSignUp ? signUp : signIn)
                    
                    DesignSystem.ButtonStyle.textButton(title: isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up") {
                        isSignUp.toggle()
                    }
                }
                .padding(DesignSystem.standardPadding)
            }
            .navigationBarHidden(true)
        }
    }

    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            isUserLoggedIn = true
        }
    }

    func signIn() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            isUserLoggedIn = true
        }
    }
}
