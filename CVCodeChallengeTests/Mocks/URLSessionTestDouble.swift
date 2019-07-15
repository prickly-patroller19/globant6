
import Foundation
@testable import CVCodeChallenge

final class URLSessionTestDouble: URLSessionProtocol {
    
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask {
        defer { completionHandler(data, response, error) }
        return DataTaskTestDouble(completionHandler: completionHandler)
    }
}
