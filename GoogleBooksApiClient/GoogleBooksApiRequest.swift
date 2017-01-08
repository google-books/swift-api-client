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

    // MARK: - Bookshelf
    public struct BookshelfRequest {
        
        /// GET /users/{user_id}/bookshelves/{bookshelf_id}
        /// Retrieves a specific Bookshelf resource for the specified user.
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
        
        /// GET /users/{user_id}/bookshelves
        /// Retrieves a list of public Bookshelf resource for the specified user.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelves
            private let userId: String
            
            public init(userId: String) {
                self.userId = userId
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves", userId)
            }
            
        }

    }

    // MARK: - Volume
    public struct VolumeRequest {
        
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
    
    // MARK: - Bookshelves.Volumes
    public struct BookshelvesVolumesRequest {
        
        /// GET  /users/{userId}/bookshelves/{shelf}/volumes
        /// Retrieves volumes in a specific bookshelf for the specified user.
        public struct List: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Volumes
            private let userId: String
            private let shelf: Id<Bookshelf>
            
            public init(userId: String, shelf: Id<Bookshelf>) {
                self.userId = userId
                self.shelf = shelf
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves/%@/volumes", userId, shelf.value)
            }
            
        }
        
    }
    
}
