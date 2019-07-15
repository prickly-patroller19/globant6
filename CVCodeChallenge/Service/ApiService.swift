import Foundation

protocol ApiServiceProtocol {
    //MARK: - URLSessionProtocol type
    var session: URLSessionProtocol { get set }
    
    //MARK: - Load information method
    /**
     Load information using a request load method
     
     - parameters:
        - handler: A closure that is defined by the caller to manipulate the result network
     */
    func loadInformation(then handler: @escaping (Result<CVInformation, LoadingError>) -> Void)
}

struct ApiService: ApiServiceProtocol {
    var session: URLSessionProtocol
    let request = ApiRequest(resource: CVResource())
    typealias UserInformationHandler = (Result<CVInformation, LoadingError>) -> Void
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func loadInformation(then handler: @escaping UserInformationHandler) {
        request.load(session: session, then: handler)
    }
}
