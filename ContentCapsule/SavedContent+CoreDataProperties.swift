import Foundation
import CoreData

extension SavedContent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedContent> {
        return NSFetchRequest<SavedContent>(entityName: "SavedContent")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var dateAdded: Date?  // Ensure this line is present
}
