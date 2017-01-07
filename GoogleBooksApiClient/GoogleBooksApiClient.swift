import Foundation

// constants
private let BASE_URL: URL = URL(string: "https://www.googleapis.com/books/v1")!

// typealiases
public typealias VolumeId = String

// errors
public enum GoogleBooksApiClientError: Error {
    
    case unknown
    case httpRequestFailed(response: HTTPURLResponse, data: Data)
    case deserializationFailed(data: Data)
    
}

public class GoogleBooksApiClient {
    
    private let httpClient: HttpClient
    
    public init(session: URLSession) {
        self.httpClient = HttpClient(session: session)
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
            params: request.params,
            headers: request.headers,
            completionHandler: { (data, response, error) in
                switch GoogleBooksApiClient.getResponse(data: data, response: response, error: error) {
                case let .left(error):
                    onError(error)
                case let .right((_, d)):
                    guard let volume = GoogleBooksApiClient.deserialize(data: d, converter: B.create) else {
                        onError(GoogleBooksApiClientError.deserializationFailed(data: d))
                        return
                    }
                    onSuccess(volume)
                }
            }
        )
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
