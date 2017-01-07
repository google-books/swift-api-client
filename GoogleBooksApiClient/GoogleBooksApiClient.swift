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
                guard error == nil else {
                    onError(error!)
                    return
                }
                guard let response = response, let data = data else {
                    onError(GoogleBooksApiClientError.unknown)
                    return
                }
            
                if 200..<300 ~= response.statusCode {
                    guard let volume = GoogleBooksApiClient.deserialize(data: data, converter: Volume.create) else {
                        onError(GoogleBooksApiClientError.deserializationFailed(data: data))
                        return
                    }
                    onSuccess(volume)
                } else {
                    onError(GoogleBooksApiClientError.httpRequestFailed(response: response, data: data))
                }
        })
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
