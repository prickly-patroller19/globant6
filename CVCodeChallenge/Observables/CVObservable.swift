import Foundation

struct JobsGroup {
    var job: CVObservable<String> = CVObservable("")
    var place: CVObservable<String> = CVObservable("")
    var start: CVObservable<String> = CVObservable("")
    var end: CVObservable<String> = CVObservable("")
    var summary: CVObservable<String> = CVObservable("")
}

struct SkillsGroup {
    var skill: CVObservable<String> = CVObservable("")
    var level: CVObservable<Int> = CVObservable(0)
}

struct SchoolGroup {
    var degree: CVObservable<String> = CVObservable("")
    var period: CVObservable<String> = CVObservable("")
}

final class CVObservable<T> {
    
    private var cvValue: T?
    var value: T? {
        get {
            return cvValue
        }
        set {
            cvValue = newValue
            valueChanged?(cvValue)
        }
    }
    
    var valueChanged: ((T?) -> Void)?
    
    init(_ value: T) {
        cvValue = value
    }
}

