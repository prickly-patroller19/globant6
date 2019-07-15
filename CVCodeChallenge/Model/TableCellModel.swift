import Foundation

// MARK: - TableCellModel
struct TableCellModel {
    var opened: Bool
    var cellTitle: String
    var sectionData: [SectionData]
    var color: (Double,Double,Double)
}

// MARK: - SectionData
struct SectionData {
    var subCellTitle: String
    var subCellInformation: String
}
