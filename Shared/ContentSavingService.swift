import Foundation
import CoreData

class ContentSavingService {
    static func saveContent(title: String, url: String) {
        let context = CoreDataStack.shared.context
        let newContent = SavedContent(context: context)
        newContent.title = title
        newContent.url = url
        newContent.dateAdded = Date()
        
        do {
            try context.save()
            print("Content saved: \(newContent)")
        } catch {
            print("Failed to save content: \(error.localizedDescription)")
        }
    }
}
