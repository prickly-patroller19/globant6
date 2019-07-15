import Foundation

//MARK: - Type of Loading error
enum LoadingError: Error {
    case loadFail
    case nilData
    case decodeFail
}
