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
    
    /// GET /volumes/{volume_id}
    /// Retrieves a Volume resource based on ID.
    public func getVolume(id: Id<Volume>, onSuccess: @escaping (Volume) -> Void, onError: @escaping (Error) -> Void) -> URLSessionDataTask {
        return self.httpClient.get(
            url: BASE_URL.appendingPathComponent(String(format: "/volumes/%@", id.value)),
            completionHandler: { (data, response, error) in
                switch GoogleBooksApiClient.getResponse(data: data, response: response, error: error) {
                case let .left(error):
                    onError(error)
                case let .right((_, d)):
                    guard let volume = GoogleBooksApiClient.deserialize(data: d, converter: Volume.create) else {
                        onError(GoogleBooksApiClientError.deserializationFailed(data: d))
                        return
                    }
                    onSuccess(volume)
                }
            }
        )
    }
    
    /// GET /volumes?q={search_terms}
    /// Performs a book search.
    public func getVolumes(query: String, onSuccess: @escaping ([Volume]) -> Void, onError: @escaping (Error) -> Void) -> URLSessionDataTask {
        return self.httpClient.get(
            url: BASE_URL.appendingPathComponent("/volumes"),
            params: [("q", query)],
            completionHandler: { (data, response, error) in
                switch GoogleBooksApiClient.getResponse(data: data, response: response, error: error) {
                case let .left(error):
                    onError(error)
                case let .right((_, d)):
                    guard let volumes = GoogleBooksApiClient.deserialize(data: d, converter: [Volume].create) else {
                        onError(GoogleBooksApiClientError.deserializationFailed(data: d))
                        return
                    }
                    onSuccess(volumes)
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
