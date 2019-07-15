import Foundation

struct ApiRequest<Resource: ApiResource> {
    let resource: Resource
}

extension ApiRequest: NetworkRequest {
    
    typealias LoadedType = Resource.Model
    
    @discardableResult
    
    func load(session: URLSessionProtocol = URLSession(configuration: .default), then handler: @escaping (Result<Resource.Model, LoadingError>) -> Void) -> RequestToken {
        return self.load(session: session, url: resource.url, then: handler)
    }
    
    func decode(_ data: Data) throws -> Resource.Model {
        return try resource.makeModel(fromData: data)
    }
}
