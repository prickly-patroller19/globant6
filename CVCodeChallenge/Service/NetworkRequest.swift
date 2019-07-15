import Foundation

protocol NetworkRequest {
    associatedtype LoadedType
    
    //MARK: - Load method
    /**
     Use a URLSessionProtocol and an URL to get a network result type
     
     - parameters:
        - session: URLSessionProtocol type
        - url: URL type
        - handler: Closure that will be define by the caller
    */
    func load(session: URLSessionProtocol, url: URL, then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken
    
    //MARK: - Decode method
    /**
     
     - returns: LoadedType
     - parameters:
        - data: Use a Data type
    */
    func decode(_ data: Data) throws -> LoadedType
}

protocol URLSessionProtocol {
     func dataTask(with urlRequest: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

extension NetworkRequest {
    
    @discardableResult
    func load(session: URLSessionProtocol = URLSession(configuration: .default), url: URL, then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data: Data?, _: URLResponse?, error: Error?) in
            if error != nil {
                handler(Result.failure(.loadFail))
                return
            }
            guard let data = data else {
                handler(Result.failure(.nilData))
                return
            }
            do {
                let loadedType = try self.decode(data)
                handler(Result.success(loadedType))
            } catch {
                handler(Result.failure(.decodeFail))
            }
        }
        task.resume()
        return RequestToken(task: task)
    }
}
