import Foundation

public struct GoogleApiToken {
    
    public let accessToken: String
    public let expiresIn: Int
    public let refreshToken: String
    public let tokenType: String
    public let updatedAt: Date = Date()
    
    public func isExpired(at: NSDate = NSDate()) -> Bool {
        return at.timeIntervalSince(updatedAt) > Double(expiresIn)
    }
    
}

extension GoogleApiToken: Deserializable {
    
    public static func create(_ dict: [AnyHashable : Any]) -> GoogleApiToken? {
        guard
            let accessToken = dict["access_token"] as? String,
            let expiresIn = dict["expires_in"] as? Int,
            let refreshToken = dict["refresh_token"] as? String,
            let tokenType = dict["token_type"] as? String
            else { return nil }
        return GoogleApiToken(
            accessToken: accessToken,
            expiresIn: expiresIn,
            refreshToken: refreshToken,
            tokenType: tokenType
        )
    }
    
}
