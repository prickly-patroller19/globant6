
import XCTest
@testable import CVCodeChallenge

final class TableViewModelTests: XCTestCase {
    
    func testUpdateCellsOK() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.updateCells()
        XCTAssertEqual(sut.name.value, infoCV.info.name)
        XCTAssertEqual(sut.surname.value, infoCV.info.surnames)
        XCTAssertEqual(sut.age.value, infoCV.info.age)
        XCTAssertEqual(sut.nationality.value, infoCV.info.nationality)
        XCTAssertEqual(sut.mail.value, infoCV.contact.mail)
        XCTAssertEqual(sut.phone.value, infoCV.contact.phone)
        XCTAssertEqual(sut.webpage.value, infoCV.contact.webpage)
    }
    
    func testUpdateCellsExperienceOK(){
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        
        //Array initialitation
        sut.cvInformation?.experience.forEach { experience in
            sut.jobs.append(JobsGroup())
        }
        
        sut.updateCellsExperience()
        for (index, _) in sut.jobs.enumerated() {
            XCTAssertEqual(sut.jobs[index].job.value, infoCV.experience[index].job)
            XCTAssertEqual(sut.jobs[index].place.value, infoCV.experience[index].place)
        }
    }
    
    func testUpdateCellsSkillsOK() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        
        //Array initialitation
        sut.cvInformation?.skills.forEach{ skill in
            sut.skills.append(SkillsGroup())
        }
        
        sut.updateCellsSkills()
        for (index, _) in sut.skills.enumerated() {
            XCTAssertEqual(sut.skills[index].skill.value, infoCV.skills[index].skill)
        }
    }
    
    func testUpdateCellsSchoolOK() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        
        //Array initialitation
        sut.cvInformation?.education.forEach{ skill in
            sut.schools.append(SchoolGroup())
        }
        
        sut.updateCellsSchools()
        for (index, _) in sut.schools.enumerated() {
            XCTAssertEqual(sut.schools[index].degree.value, infoCV.education[index].degree)
            XCTAssertEqual(sut.schools[index].period.value, infoCV.education[index].period)
        }
    }
    
    func testFillCallsLoadInformationOK(){
        let sut = TableViewModel()
        let apiServiceMocked = ApiServiceTestDouble(session: URLSessionTestDouble(data: nil, response: nil, error: nil))
        sut.apiService = apiServiceMocked
        sut.fill()
        XCTAssertTrue(apiServiceMocked.loadInformationWasCalled)
    }
    
    func testFillExperienceOk() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.fillExperienceArrays()
        XCTAssertEqual(infoCV.experience.count, sut.jobs.count)
    }
    
    func testFillSkillsArrayOk() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.fillSkillsArrays()
        XCTAssertEqual(infoCV.skills.count, sut.skills.count)
    }
    
    func testSchoolsArrayOk() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.fillSchoolsArrays()
        XCTAssertEqual(infoCV.education.count, sut.schools.count)
    }
    
    func testFillTableOK() {
        let sut = TableViewModel()
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.fillTable()
        
        XCTAssertEqual(sut.tableCellModel.count, 5)
    }
    
    func testCompelteDidLoadCallsWithSuccess() {
        let sut = TableViewModel()
        let calledExpectation = expectation(description: "")
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.completeDidLoad = {
            DispatchQueue.main.async {
                calledExpectation.fulfill()
            }
        }
        sut.fillTable()
        wait(for: [calledExpectation], timeout: 1)
    }
    
    func testLoadDidFail() {
        let sut = TableViewModel()
        let mockURLSession = URLSessionTestDouble(data: nil, response: nil, error: LoadingError.loadFail)
        sut.apiService = ApiService(session: mockURLSession)
        let calledExpectation = expectation(description: "")
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let decoder = JSONDecoder()
        guard let infoCV = try? decoder.decode(CVInformation.self, from: data) else {
            XCTFail()
            return
        }
        sut.cvInformation = infoCV
        sut.loadDidFail = {
            DispatchQueue.main.async {
                calledExpectation.fulfill()
            }
        }
        sut.fill()
        wait(for: [calledExpectation], timeout: 1)
    }
}
