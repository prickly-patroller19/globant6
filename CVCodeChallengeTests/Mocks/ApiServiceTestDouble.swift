import Foundation
@testable import CVCodeChallenge

final class ApiServiceTestDouble: ApiServiceProtocol {
    var session: URLSessionProtocol
    var loadInformationWasCalled: Bool = false
    
    init(session: URLSessionTestDouble) {
        self.session = session
    }

    func loadInformation(then handler: @escaping (Result<CVInformation, LoadingError>) -> Void) {
        loadInformationWasCalled = true
    }
}
