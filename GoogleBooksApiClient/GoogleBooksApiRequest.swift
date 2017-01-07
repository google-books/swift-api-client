import Foundation

private let BASE_URL: URL = URL(string: "https://www.googleapis.com/books/v1")!

public protocol GoogleBooksApiRequest {
    
    associatedtype Result
    
}

protocol GoogleBooksApiRequestType {

    var method: HttpMethod { get }
    var path: String { get }
    var url: URL { get }
    var params: [RequestParameter] { get }
    var headers: [RequestHeader] { get }
    
}

extension GoogleBooksApiRequestType {
    
    var url: URL {
        return BASE_URL.appendingPathComponent(path)
    }
    
    var params: [RequestParameter] {
        return []
    }
    
    var headers: [RequestHeader] {
        return []
    }
    
}

public struct GoogleBooksApi {
    
    public struct BookshelfRequest {
        
        // MARK: - Bookshelf
        public struct Get: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelf
            private let id: Id<Bookshelf>
            private let userId: String
            
            public init(id: Id<Bookshelf>, userId: String) {
                self.id = id
                self.userId = userId
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves/%@", userId, id.value)
            }
            
        }

    }
    
    public struct VolumeRequest {
        
        // MARK: - Volume
        /// GET /volumes/{volume_id}
        /// Retrieves a Volume resource based on ID.
        public struct Get: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Volume
            private let id: Id<Volume>
            
            public init(id: Id<Volume>) {
                self.id = id
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/volumes/%@", id.value)
            }
            
        }
        
        /// GET /volumes?q={search_terms}
        /// Performs a book search.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Volumes
            private let query: String
            
            public init(query: String) {
                self.query = query
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return "/volumes"
            }
            
            var params: [RequestParameter] {
                return [("q", query)]
            }
            
        }
        
    }
    
    
}
