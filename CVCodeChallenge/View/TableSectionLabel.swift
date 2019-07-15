import UIKit

class TableSectionLabel: UILabel {
    var section: TableSection?
    
    func setAccesibilityIdentifiers(){
        guard let section = section else { return }
        switch section {
        case .profile:
            self.accessibilityIdentifier = AccessibilityIdentifiers.section_profile.rawValue
        case .contact:
            self.accessibilityIdentifier = AccessibilityIdentifiers.section_contact.rawValue
        case .experience:
            self.accessibilityIdentifier = AccessibilityIdentifiers.section_experience.rawValue
        case .skills:
            self.accessibilityIdentifier = AccessibilityIdentifiers.section_skills.rawValue
        case .education:
            self.accessibilityIdentifier = AccessibilityIdentifiers.section_education.rawValue
        }
    }
}
