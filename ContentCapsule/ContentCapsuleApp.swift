import SwiftUI
import Firebase

@main
struct ContentCapsuleApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
