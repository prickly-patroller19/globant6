import Foundation
@testable import CVCodeChallenge

final class DataTaskTestDouble: URLSessionDataTask {
    var completionHandler: (Data?, URLResponse?, Error?) -> Void
    
    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        //Do nothing
    }
}
