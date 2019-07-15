import UIKit

final class TableViewModel: NSObject, TableViewModelProtocol {
    
    // MARK: - Variables
    var cvInformation: CVInformation?
    var completeDidLoad: (() -> Void)?
    var reload: ((Int) -> Void)?
    var loadDidFail: (() -> Void)?
    var apiService: ApiServiceProtocol? = ApiService()
    var tableCellModel = [TableCellModel]()
    
    private var skillsTable = [SectionData]()
    private var jobsTable = [SectionData]()
    private var schoolsTable = [SectionData]()
    
    //MARK: - Observables properties
    var name: CVObservable<String> = CVObservable("")
    var surname: CVObservable<String> = CVObservable("")
    var age: CVObservable<Int> = CVObservable(0)
    var nationality: CVObservable<String> = CVObservable("")
    
    var mail: CVObservable<String> = CVObservable("")
    var phone: CVObservable<String> = CVObservable("")
    var webpage: CVObservable<String> = CVObservable("")
    
    var school: CVObservable<String> = CVObservable("")
    var degree: CVObservable<String> = CVObservable("")
    var period: CVObservable<String> = CVObservable("")
    
    var jobs: [JobsGroup] = [JobsGroup]()
    var skills: [SkillsGroup] = [SkillsGroup]()
    var schools: [SchoolGroup] = [SchoolGroup]()
        
    // MARK: - Functions
    func fill() {
        apiService?.loadInformation{ (result: Result<CVInformation, LoadingError>) in
            switch result {
            case .success(let response):
                self.cvInformation = response
                self.fillTable()
                break
            case .failure:
                self.loadDidFail?()
                self.cvInformation = nil
            }
        }
    }
    
    //MARK: - Methods fot set values for observables
    func updateCells() {
        name.value = cvInformation?.info.name
        surname.value = cvInformation?.info.surnames
        age.value = cvInformation?.info.age
        nationality.value = cvInformation?.info.nationality
        mail.value = cvInformation?.contact.mail
        phone.value = cvInformation?.contact.phone
        webpage.value = cvInformation?.contact.webpage
    }
    
    func updateCellsExperience() {
        guard let experiences = cvInformation?.experience else { return }
        for (index, value) in experiences.enumerated() {
            jobs[index].job.value = value.job
            jobs[index].place.value = value.place
        }
    }
    
    func updateCellsSkills() {
        guard let technologies = cvInformation?.skills else { return }
        for (index, value) in technologies.enumerated() {
            skills[index].skill.value = value.skill
        }
    }
    
    func updateCellsSchools() {
        guard let institutes = cvInformation?.education else { return }
        for (index, value) in institutes.enumerated() {
            schools[index].degree.value = value.degree
            schools[index].period.value = value.period
        }
    }
    
    //MARK: - Fill methods for view
    func fillExperienceArrays() {
        cvInformation?.experience.forEach { experience in
            jobs.append(JobsGroup())
        }
    }
    
    func fillSkillsArrays() {
        cvInformation?.skills.forEach { skill in
            skills.append(SkillsGroup())
        }
    }
    
    func fillSchoolsArrays() {
        cvInformation?.education.forEach { skill in
            schools.append(SchoolGroup())
        }
    }
    
    func fillTable() {
        let nameCell = SectionData(subCellTitle: "ProfileName".localized(), subCellInformation: "")
        let surnameCell = SectionData(subCellTitle: "ProfileSurname".localized(), subCellInformation: "")
        let ageCell = SectionData(subCellTitle: "ProfileAge".localized(), subCellInformation: "")
        let nationalityCell = SectionData(subCellTitle: "ProfileNationality".localized(), subCellInformation: nationality.value ?? "")
        tableCellModel.append(TableCellModel(opened: false, cellTitle: "ProfileTitle".localized(), sectionData: [nameCell, surnameCell, ageCell, nationalityCell], color: GrayColor.gray1))
        
        let mailCell = SectionData(subCellTitle: "ProfileEmail".localized(), subCellInformation: "")
        let phoneCell = SectionData(subCellTitle: "ProfilePhone".localized(), subCellInformation: "")
        let webCell = SectionData(subCellTitle: "ProfileWeb".localized(), subCellInformation: "")
        
        tableCellModel.append(TableCellModel(opened: false, cellTitle: "ProfileContact".localized(), sectionData: [mailCell, phoneCell, webCell], color: GrayColor.gray2))
        
        guard let jobs = cvInformation?.experience else { return }
        for _ in jobs {
            jobsTable.append(SectionData(subCellTitle: "", subCellInformation: ""))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                             cellTitle: "JobsTitle".localized(),
                                             sectionData: jobsTable, color: GrayColor.gray3))
        
        guard let skills = cvInformation?.skills else { return }
        for _ in skills {
            skillsTable.append(SectionData(subCellTitle: "", subCellInformation: ""))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                             cellTitle: "SkillsTitle".localized(),
                                             sectionData: skillsTable, color: GrayColor.gray4))
        
        guard let institutes = cvInformation?.education else { return }
        for _ in institutes {
            schoolsTable.append(SectionData(subCellTitle: "", subCellInformation: ""))
        }
        tableCellModel.append(TableCellModel(opened: false,
                                             cellTitle: "SchoolTitle".localized(),
                                             sectionData: schoolsTable, color: GrayColor.gray5))
        completeDidLoad?()
    }
}
