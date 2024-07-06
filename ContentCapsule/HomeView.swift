import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.backgroundColor.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: DesignSystem.standardPadding) {
                        Text("Welcome to Content Capsule!")
                            .font(DesignSystem.titleFont)
                            .foregroundColor(DesignSystem.textColor)
                        
                        Text("Your personal knowledge management app")
                            .font(DesignSystem.bodyFont)
                            .foregroundColor(DesignSystem.textColor.opacity(0.7))
                        
                        // Example content cards
                        ContentCard(title: "Sample Article", source: "Example.com", date: "July 5, 2024", summary: "This is a sample article summary.")
                        ContentCard(title: "Another Article", source: "TestSite.org", date: "July 4, 2024", summary: "This is another sample article summary.")
                    }
                    .padding()
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}
