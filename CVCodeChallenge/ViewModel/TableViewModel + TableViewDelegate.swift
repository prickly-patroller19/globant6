import UIKit

extension TableViewModel: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return tableCellModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableCellModel[section].opened {
            return tableCellModel[section].sectionData.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let textLabel = TableSectionLabel()
        textLabel.section = TableSection(rawValue: section)
        textLabel.font = UIFont.boldSystemFont(ofSize: TableSizes.Header.fontSize)
        textLabel.text = tableCellModel[section].cellTitle.ident(identation: 4)
        let (red,green,blue) = tableCellModel[section].color
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        textLabel.backgroundColor = color
        textLabel.setAccesibilityIdentifiers()
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        textLabel.addGestureRecognizer(tap)
        textLabel.isUserInteractionEnabled = true
        return textLabel
    }
    
    @objc func singleTap(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let label = tapGestureRecognizer.view as? TableSectionLabel, let section = label.section else { return }
        
        tableCellModel[section.rawValue].opened.toggle()
        
        switch section {
        case .profile, .contact:
            break
        case .experience:
            fillExperienceArrays()
        case .skills:
            fillSkillsArrays()
        case .education:
            fillSchoolsArrays()
        }
        
        reload?(section.rawValue)
        
        switch section {
        case .profile, .contact:
            break
        case .experience:
            updateCellsExperience()
        case .skills:
            updateCellsSkills()
        case .education:
            updateCellsSchools()
        }
     
        updateCells()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return TableSizes.Header.height
    }
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.profile.rawValue, for: indexPath) as? DetailTableViewCell {
                return createDetail(using: cell, in: indexPath)
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.contact.rawValue, for: indexPath) as? DetailTableViewCell {
                return createDetail(using: cell, in: indexPath)
            } else {
                return UITableViewCell()
            }
        }
        else if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.job.rawValue, for: indexPath) as? DetailTableViewCell {
                return createDetail(using: cell, in: indexPath)
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 3 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.skill.rawValue, for: indexPath) as? DetailTableViewCell {
                return createDetail(using: cell, in: indexPath)
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 4 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.education.rawValue, for: indexPath) as? DetailTableViewCell {
                return createDetail(using: cell, in: indexPath)
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TableSizes.Header.height
        } else {
            return TableSizes.Detail.height
        }
    }
}

private extension TableViewModel {
    


    func createHeader(using cell: UITableViewCell, in index: IndexPath) -> UITableViewCell {
        cell.textLabel?.text = tableCellModel[index.section].cellTitle
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: TableSizes.Header.fontSize)
        guard let section = TableSection(rawValue: index.section) else { return cell }
        switch section {
        case .profile:
            cell.accessibilityIdentifier = AccessibilityIdentifiers.section_profile.rawValue
        case .contact:
            cell.accessibilityIdentifier = AccessibilityIdentifiers.section_contact.rawValue
        case .experience:
            cell.accessibilityIdentifier = AccessibilityIdentifiers.section_experience.rawValue
        case .skills:
            cell.accessibilityIdentifier = AccessibilityIdentifiers.section_skills.rawValue
        case .education:
            cell.accessibilityIdentifier = AccessibilityIdentifiers.section_education.rawValue
        }
        return cell
    }

    func createDetail(using cell: DetailTableViewCell, in index: IndexPath) ->
        DetailTableViewCell {
            guard let section = TableSection(rawValue: index.section) else { return cell }
            switch section {
            case .profile:
                cell.title.text = tableCellModel[index.section].sectionData[index.row].subCellTitle
                switch index.row {
                case 0:
                    cell.detail.bind(to: name)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.detail_name.rawValue
                case 1:
                    cell.detail.bind(to: surname)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.detail_surname.rawValue
                case 2:
                    cell.detail.bind(to: age)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.detail_age.rawValue
                case 3:
                    cell.detail.bind(to: nationality)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.detail_nationality.rawValue
                default:
                    break
                }
            case .contact:
                cell.title.text = tableCellModel[index.section].sectionData[index.row].subCellTitle
                switch index.row {
                case 0:
                    cell.detail.bind(to: mail)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.contact_mail.rawValue
                case 1:
                    cell.detail.bind(to: phone)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.contact_phone.rawValue
                case 2:
                    cell.detail.bind(to: webpage)
                    cell.accessibilityIdentifier = AccessibilityIdentifiers.contact_web.rawValue
                default:
                    break
                }
            case .experience:
                cell.title.bind(to: jobs[index.row].job)
                cell.detail.bind(to: jobs[index.row].place)
                cell.accessibilityIdentifier = AccessibilityIdentifiers.cell_experience.rawValue
            case .skills:
                cell.detail.bind(to: skills[index.row].skill)
                cell.accessibilityIdentifier = AccessibilityIdentifiers.cell_skills.rawValue
            case .education:
                cell.title.bind(to: schools[index.row].degree)
                cell.detail.bind(to: schools[index.row].period)
                cell.accessibilityIdentifier = AccessibilityIdentifiers.cell_education.rawValue
            }
        cell.title.font = UIFont.boldSystemFont(ofSize: TableSizes.Detail.fontSize)
        cell.detail.font = UIFont.systemFont(ofSize: TableSizes.Detail.fontSize)
        return cell
    }
}
