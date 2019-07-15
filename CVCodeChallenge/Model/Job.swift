import Foundation

// MARK: - Job model
struct Job: Codable {
    var job: String
    var place: String
    var start: String
    var end: String
    var description: String
}
