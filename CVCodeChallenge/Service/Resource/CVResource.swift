import Foundation

final class CVResource: ApiResource {
    
    typealias Model = CVInformation
    var url: URL
    
    init() {
        var components = URLComponents()
        components.scheme = Environment.rootScheme
        components.host = Environment.rootHost
        components.path = Environment.rootPath
        guard let url = components.url else { fatalError("url not valid") }
        self.url = url
    }
    
    func makeModel(fromData data: Data) throws -> Model {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Model.self, from: data)
    }
}
