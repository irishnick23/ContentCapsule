import Foundation
import FirebaseFirestore

struct UserProfile: Codable, Identifiable {
    var id: String?
    var phoneNumber: String
    var name: String?
    var email: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case phoneNumber
        case name
        case email
    }
}
