import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var username = ""
    @State private var isEditingProfile = false
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn = true

    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: DesignSystem.standardPadding) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(DesignSystem.secondaryColor)
                            .padding()
                        
                        if isEditingProfile {
                            CustomTextField(placeholder: "Username", text: $username)
                                .padding(.horizontal)
                            
                            DesignSystem.ButtonStyle.primaryButton(title: "Save Profile", action: updateProfile)
                                .padding(.horizontal)
                        } else {
                            Text(username.isEmpty ? "Set your username" : username)
                                .font(DesignSystem.bodyFont)
                                .foregroundColor(DesignSystem.textColor)
                        }
                        
                        SettingsRow(icon: "gear", title: "App Settings")
                        SettingsRow(icon: "bell", title: "Notifications")
                        SettingsRow(icon: "lock", title: "Privacy")
                        SettingsRow(icon: "questionmark.circle", title: "Help & Support")
                        
                        DesignSystem.ButtonStyle.secondaryButton(title: "Sign Out", action: signOut)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button(action: {
                isEditingProfile.toggle()
            }) {
                Text(isEditingProfile ? "Cancel" : "Edit")
            })
        }
    }
    
    private func updateProfile() {
        // Implement profile update functionality here
        print("Updating profile with username: \(username)")
        isEditingProfile = false
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(DesignSystem.primaryColor)
                .frame(width: 30)
            Text(title)
                .foregroundColor(DesignSystem.textColor)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
