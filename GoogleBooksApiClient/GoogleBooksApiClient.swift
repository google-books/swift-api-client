import Foundation

// errors
public enum GoogleBooksApiClientError: Error {
    
    case unknown
    case httpRequestFailed(response: HTTPURLResponse, data: Data)
    case deserializationFailed(data: Data)
    
}

public final class GoogleBooksApiClient {
    
    private let httpClient: HttpClient
    
    public init(session: URLSession) {
        self.httpClient = HttpClient(session: session)
    }
    
    public func invoke<A: GoogleBooksApiRequest>(_ request: A, onSuccess: @escaping (Bool) -> Void, onError: @escaping (Error) -> Void) -> URLSessionDataTask
    where A.Result == Bool {
        guard let request = request as? GoogleBooksApiRequestType else {
            onError(GoogleBooksApiClientError.unknown)
            return URLSessionDataTask()
        }
        return httpClient.execute(
            method: request.method,
            url: request.url,
            params: GoogleBooksApiClient.getParams(params: request.params, authInfo: request.authInfo),
            headers: GoogleBooksApiClient.getHeaders(headers: request.headers, authInfo: request.authInfo),
            completionHandler: { (data, response, error) in
                switch GoogleBooksApiClient.getResponse(data: data, response: response, error: error) {
                case let .left(error): onError(error)
                case .right(_): onSuccess(true)
                }
            }
        )
    }

    
    public func invoke<A: GoogleBooksApiRequest, B: Deserializable>(_ request: A, onSuccess: @escaping (B) -> Void, onError: @escaping (Error) -> Void) -> URLSessionDataTask
    where A.Result == B {
        guard let request = request as? GoogleBooksApiRequestType else {
            onError(GoogleBooksApiClientError.unknown)
            return URLSessionDataTask()
        }
        return httpClient.execute(
            method: request.method,
            url: request.url,
            params: GoogleBooksApiClient.getParams(params: request.params, authInfo: request.authInfo),
            headers: GoogleBooksApiClient.getHeaders(headers: request.headers, authInfo: request.authInfo),
            completionHandler: { (data, response, error) in
                switch GoogleBooksApiClient.getResponse(data: data, response: response, error: error) {
                case let .left(error):
                    onError(error)
                case let .right((_, d)):
                    guard let deserialized = GoogleBooksApiClient.deserialize(data: d, converter: B.create) else {
                        onError(GoogleBooksApiClientError.deserializationFailed(data: d))
                        return
                    }
                    onSuccess(deserialized)
                }
            }
        )
    }
    
    private static func getParams(params: [RequestParameter], authInfo: GoogleBooksApiAuthInfo?) -> [RequestParameter] {
        let apiKeyParam: [RequestParameter] = authInfo?.apiKey.map({[("key", $0)]}) ?? []
        return params + apiKeyParam
    }
    
    private static func getHeaders(headers: [RequestHeader], authInfo: GoogleBooksApiAuthInfo?) -> [RequestHeader] {
        let authorizationHeader: [RequestHeader] = authInfo?.authToken.map({[("Authorization", "Bearer " + $0)]}) ?? []
        return headers + authorizationHeader
    }
    
    private static func getResponse(data: Data?, response: HTTPURLResponse?, error: Error?) -> Either<Error, (HTTPURLResponse, Data)> {
        if let error = error {
            return .left(error)
        } else if let response = response, let data = data {
            return 200..<300 ~= response.statusCode ?
                .right((response, data)) :
                .left(GoogleBooksApiClientError.httpRequestFailed(response: response, data: data))
        } else {
            return .left(GoogleBooksApiClientError.unknown)
        }
    }
    
    private static func deserialize<T>(data: Data, converter: ([AnyHashable:Any]) -> T?) -> T? {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:Any] else {
                return nil
            }
            return converter(json)
        } catch {
            return nil
        }
    }
    
}
