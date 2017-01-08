import Foundation

typealias RequestParameter = (key: String, value: String)
typealias RequestHeader = (key: String, value: String)

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

class HttpClient {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func execute(method: HttpMethod, url: URL, params: [RequestParameter]?, headers: [RequestHeader]?, completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = params?.map({ URLQueryItem(name: $0.key, value: $0.value) })
        var request = components?.url.map({ URLRequest(url: $0) })
        request?.httpMethod = method.rawValue
        for (key, value) in headers ?? [] {
            request?.setValue(value, forHTTPHeaderField: key)
        }
        let task = session.dataTask(with: request!, completionHandler: { (data, response, error) in
            guard let response = response, let data = data else {
                completionHandler(nil, nil, HttpClientError.unknown)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(data, nil, HttpClientError.nonHTTPResponse(response: response))
                return
            }
            completionHandler(data, httpResponse, error)
        })
        task.resume()
        return task
    }
    
}

enum HttpClientError: Error {
    
    case unknown
    case nonHTTPResponse(response: URLResponse)
    
}
