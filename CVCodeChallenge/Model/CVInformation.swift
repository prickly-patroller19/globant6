import Foundation

// MARK: - CVInformation model
struct CVInformation: Codable {
    let info: Info
    let contact: Contact
    let education: [Education]
    let experience: [Job]
    let skills: [Skill]
}
