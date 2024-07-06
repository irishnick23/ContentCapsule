import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var searchResults: [String] = []  // Replace with actual content type

    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: DesignSystem.standardPadding) {
                    SearchBar(text: $searchText, placeholder: "Search your content")
                        .padding(.horizontal)
                    
                    if searchResults.isEmpty {
                        EmptyStateView(
                            image: "magnifyingglass",
                            title: "No Results",
                            message: "Try searching for a different term"
                        )
                    } else {
                        List(searchResults, id: \.self) { result in
                            Text(result)  // Replace with ContentCard when available
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.large)
        }
        .onChange(of: searchText) { oldValue, newValue in
            performSearch()
        }
    }
    
    private func performSearch() {
        // Implement actual search logic here
        searchResults = searchText.isEmpty ? [] : ["Result 1", "Result 2", "Result 3"]
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .foregroundColor(.primary)
            
            if !text.isEmpty {
                Button(action: {
                    self.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct EmptyStateView: View {
    let image: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: image)
                .font(.system(size: 60))
                .foregroundColor(DesignSystem.secondaryColor)
            
            Text(title)
                .font(DesignSystem.titleFont)
                .foregroundColor(DesignSystem.textColor)
            
            Text(message)
                .font(DesignSystem.bodyFont)
                .foregroundColor(DesignSystem.textColor.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
