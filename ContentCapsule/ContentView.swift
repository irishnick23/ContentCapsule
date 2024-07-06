import SwiftUI

struct ContentView: View {
    @AppStorage("isUserLoggedIn") private var isUserLoggedIn = false

    var body: some View {
        if isUserLoggedIn {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                SaveView()
                    .tabItem {
                        Label("Save", systemImage: "plus")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
            .accentColor(DesignSystem.secondaryColor)
        } else {
            AuthView()
        }
    }
}
