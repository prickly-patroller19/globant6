import Foundation

protocol ApiResource {
    associatedtype Model
    //MARK: - URL type
    var url: URL { get }
    
    //MARK: - Make model method
    /**
     Make a CV information model with a Data
     
     - parameters:
        - data: A Data type
    */
    func makeModel(fromData data: Data) throws -> Model
}
