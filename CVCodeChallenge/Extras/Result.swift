import Foundation

//MARK: - Type of network result
enum Result<S, F> where F: Error {
    case success(S)
    case failure(F)
}
