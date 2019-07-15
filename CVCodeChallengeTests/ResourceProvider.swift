import Foundation
@testable import CVCodeChallenge

class ResourceProvider {
    static func getCVInfoWith(name: String, format: String) -> Data {
        guard let url = Bundle.main.url(forResource: name, withExtension: format) else {
            fatalError("Invalid URL.")
        }
        guard let data = try? Data(contentsOf: url, options: .alwaysMapped) else {
            return Data()
        }
        
        return data
    }
}
