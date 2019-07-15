import Foundation

protocol TableViewModelProtocol {
    var cvInformation: CVInformation? { get set }
    var apiService: ApiServiceProtocol? { get set }
}
