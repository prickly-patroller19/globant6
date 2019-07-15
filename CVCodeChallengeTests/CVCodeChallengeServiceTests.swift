import XCTest
@testable import CVCodeChallenge

class APIServiceTests: XCTestCase {
    
    var sessionUnderTest: URLSession?
    var apiServiceUnderTest: ApiService?
    
    override func setUp() {
        super.setUp()
        sessionUnderTest = URLSession(configuration: .default)
        apiServiceUnderTest = ApiService()
    }
    
    override func tearDown() {
        sessionUnderTest = nil
        apiServiceUnderTest = nil
        super.tearDown()
    }
    
    func testAPIServiceLoadsInformationWithSuccess() {
        let data = ResourceProvider.getCVInfoWith(name: "CVInfo", format: "json")
        let sucessExpectation = expectation(description: "Response with sucess")
        let sessionMocked = URLSessionTestDouble(data: data, response: nil, error: nil)
        let sut = ApiService(session: sessionMocked)
        
        sut.loadInformation{ result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                sucessExpectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [sucessExpectation], timeout: 1)
    }
    
    func testAPIServiceLoadsInformationWithFailureBadInfo() {
        let data = ResourceProvider.getCVInfoWith(name: "badCVInfo", format: "json")
        let sucessExpectation = expectation(description: "Response with sucess")
        let sessionMocked = URLSessionTestDouble(data: data, response: nil, error: nil)
        let sut = ApiService(session: sessionMocked)
        
        sut.loadInformation { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .decodeFail)
                sucessExpectation.fulfill()
            }
        }
        
        wait(for: [sucessExpectation], timeout: 1)
    }
    
    
    func testAPIServiceLoadsInformationWithFailureDataNil() {

        let sucessExpectation = expectation(description: "Response with sucess")
        let sessionMocked = URLSessionTestDouble(data: nil, response: nil, error: nil)
        let sut = ApiService(session: sessionMocked)
        
        sut.loadInformation { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .nilData)
                sucessExpectation.fulfill()
            }
        }
        
        wait(for: [sucessExpectation], timeout: 1)
    }
    
    func testAPIServiceLoadsInformationWithFailureLoadFail() {
        
        let sucessExpectation = expectation(description: "Response with sucess")
        let someError = LoadingError.loadFail
        let sessionMocked = URLSessionTestDouble(data: nil, response: nil, error: someError)
        let sut = ApiService(session: sessionMocked)
        
        sut.loadInformation { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, .loadFail)
                sucessExpectation.fulfill()
            }
        }
        
        wait(for: [sucessExpectation], timeout: 1)
    }
}
