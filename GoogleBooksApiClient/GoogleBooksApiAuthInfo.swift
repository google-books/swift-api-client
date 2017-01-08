import Foundation

public struct GoogleBooksApiAuthInfo {
    
    public let apiKey: String?
    public let authToken: String?
    
    public init(apiKey: String?, authToken: String?) {
        self.apiKey = apiKey
        self.authToken = authToken
    }
    
}
