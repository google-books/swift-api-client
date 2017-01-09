import Foundation

extension URLRequest {
    
    static func create(method: HttpMethod, url: URL, params: [RequestParameter], headers: [RequestHeader], authInfo: GoogleBooksApiAuthInfo?) -> URLRequest? {
        let ps = getParams(params: params, authInfo: authInfo)
        let hs = getHeaders(headers: headers, authInfo: authInfo)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = ps.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var request = components?.url.map({ URLRequest(url: $0) })
        request?.httpMethod = method.rawValue
        for (key, value) in hs {
            request?.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    private static func getParams(params: [RequestParameter], authInfo: GoogleBooksApiAuthInfo?) -> [RequestParameter] {
        let apiKeyParam: [RequestParameter] = authInfo?.apiKey.map({[("key", $0)]}) ?? []
        return params + apiKeyParam
    }
    
    private static func getHeaders(headers: [RequestHeader], authInfo: GoogleBooksApiAuthInfo?) -> [RequestHeader] {
        let authorizationHeader: [RequestHeader] = authInfo?.authToken.map({[("Authorization", "Bearer " + $0)]}) ?? []
        return headers + authorizationHeader
    }
    
}
