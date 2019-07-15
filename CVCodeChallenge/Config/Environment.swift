import Foundation

enum Environment {
    
    enum Keys {
        enum Plist {
            static let scheme = "ROOT_SCHEME"
            static let host = "ROOT_HOST"
            static let path = "ROOT_PATH"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("pList file not found")
        }
        return dict
    }()
    
    static let rootScheme: String = {
        guard let rootSchemeString = Environment.infoDictionary["ROOT_SCHEME"] as? String else {
            fatalError("ROOT_SCHEME not set in plist file")
        }
        return rootSchemeString
    }()
    
    static let rootHost: String = {
        guard let rootHostString = Environment.infoDictionary["ROOT_HOST"] as? String else {
            fatalError("ROOT_SCHEME not set in plist file")
        }
        return rootHostString
    }()
    
    static let rootPath: String = {
        guard let rootPathString = Environment.infoDictionary["ROOT_PATH"] as? String else {
            fatalError("ROOT_SCHEME not set in plist file")
        }
        return rootPathString
    }()
    
    
}
