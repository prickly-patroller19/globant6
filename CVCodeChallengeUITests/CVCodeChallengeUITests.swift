import XCTest

class CVCodeChallengeUITests: XCTestCase {
    
    var app = XCUIApplication()
    let tablesQuery = XCUIApplication().tables
    let imageQuery = XCUIApplication().images
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testSectionProfileCellsExists() {
        let myProfileCell = app.tables.otherElements[AccessibilityIdentifiers.section_profile.rawValue]
        XCTAssertTrue(myProfileCell.exists)
        myProfileCell.tap()
        // Take screenshot
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Profile Section Tapped"
        attachment.lifetime = .keepAlways
        add(attachment)

        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.detail_name.rawValue].exists)
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.detail_surname.rawValue].exists)
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.detail_age.rawValue].exists)
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.detail_nationality.rawValue].exists)
    }
    
    func testSectionContactInfoCellsExists() {
        let myContactCell = app.tables.otherElements[AccessibilityIdentifiers.section_contact.rawValue]
        XCTAssertTrue(myContactCell.exists)
        myContactCell.tap()
        // Take screenshot
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Contanct Section Tapped"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.contact_web.rawValue].exists)
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.contact_phone.rawValue].exists)
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.contact_mail.rawValue].exists)
    }
    
    func testSectionExperienceCellsExists() {
        let myExperienceCell = app.tables.otherElements[AccessibilityIdentifiers.section_experience.rawValue]
        XCTAssertTrue(myExperienceCell.exists)
        myExperienceCell.tap()
        // Take screenshot
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Experience Section Tapped"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.cell_experience.rawValue].exists)
    }
    
    func testSectionSkillsCellsExists() {
        let mySkillsCell = app.tables.otherElements[AccessibilityIdentifiers.section_skills.rawValue]
        XCTAssertTrue(mySkillsCell.exists)
        mySkillsCell.tap()
        // Take screenshot
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Skills Section Tapped"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.cell_skills.rawValue].exists)
    }
    
    func testSectionEducationCellsExists() {
        let myEducationCell = app.tables.otherElements[AccessibilityIdentifiers.section_education.rawValue]
        XCTAssertTrue(myEducationCell.exists)
        myEducationCell.tap()
        // Take screenshot
        let screenshot = app.windows.firstMatch.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Education Section Tapped"
        attachment.lifetime = .keepAlways
        add(attachment)
        
        XCTAssertTrue(app.tables.cells[AccessibilityIdentifiers.cell_education.rawValue].exists)
    }
}

// MARK: - AccessibilityIdentifiers
enum AccessibilityIdentifiers: String {
    case section_profile = "cell_section_profile_id"
    case section_contact = "cell_section_contact_id"
    case section_experience = "cell_section_experience_id"
    case section_skills = "cell_section_skills_id"
    case section_education = "cell_section_education_id"
    case detail_name = "cell_detail_name_id"
    case detail_surname = "cell_detail_surname_id"
    case detail_age = "cell_detail_age_id"
    case detail_nationality = "cell_detail_nationality_id"
    case contact_mail = "cell_contact_mail_id"
    case contact_phone = "cell_contact_phone_id"
    case contact_web = "cell_contact_web_id"
    case cell_experience = "cell_experience_id"
    case cell_skills = "cell_skills_id"
    case cell_education = "cell_education_id"
}
