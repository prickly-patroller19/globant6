import Foundation
@testable import CVCodeChallenge

struct ApiRequestTestDouble<Resource: ApiResource> {
    let resource: Resource
}

extension ApiRequestTestDouble: NetworkRequest {
    
    typealias LoadedType = Resource.Model
    
    @discardableResult
    func load(then handler: @escaping (Result<LoadedType, LoadingError>) -> Void) -> RequestToken {
        return self.load(url: resource.url, then: handler)
    }
    
    func decode(_ data: Data) throws -> Resource.Model {
        return try resource.makeModel(fromData: data)
    }
}
