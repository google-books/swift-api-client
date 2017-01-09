import Foundation

private let OAUTH2_URL = URL(string: "https://accounts.google.com/o/oauth2")!
private let BOOK_SCOPE_URL = URL(string: "https://www.googleapis.com/auth/books")!

public struct GoogleApiRequest {
    
    private init() {}
    
    public static func auth(redirectUrl: URL, clientId: String) -> URLRequest? {
        var comp = URLComponents(url: OAUTH2_URL.appendingPathComponent("/auth"), resolvingAgainstBaseURL: false)
        comp?.queryItems = [
            URLQueryItem(name: "scope", value: BOOK_SCOPE_URL.absoluteString),
            URLQueryItem(name: "redirect_uri", value: redirectUrl.absoluteString),
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: clientId)
        ]
        return comp?.url.map({ URLRequest(url: $0) })
    }
    
    public static func token(redirectUrl: URL, clientId: String, clientSecret: String, code: String) -> URLRequest {
        return token(params: [
            "redirect_uri" : redirectUrl.absoluteString,
            "grant_type" : "authorization_code",
            "client_id" : clientId,
            "client_secret" : clientSecret,
            "code" : code
        ])
    }
    
    public static func token(clientId: String, clientSecret: String, refreshToken: String) -> URLRequest {
        return token(params: [
            "grant_type" : "refresh_token",
            "client_id" : clientId,
            "client_secret" : clientSecret,
            "refresh_token" : refreshToken
        ])
    }
    
    private static func token(params: [String:String]) -> URLRequest {
        let encoded = params
            .flatMap({ param in
                guard
                    let key = param.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                    let value = param.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    else { return nil }
                return key + "=" + value
            })
            .joined(separator: "&")
        let url = OAUTH2_URL.appendingPathComponent("/token")
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpBody = encoded.data(using: .utf8)
        return req
    }
    
}
