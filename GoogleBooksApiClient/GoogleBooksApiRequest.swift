import Foundation

private let BASE_URL: URL = URL(string: "https://www.googleapis.com/books/v1")!

public typealias GoogleBooksAPIKey = String
public typealias GoogleBooksAPIAuthToken = String

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
            private let id: BookshelfId
            private let userId: String
            
            public init(id: BookshelfId, userId: String) {
                self.id = id
                self.userId = userId
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves/%@", userId, id.rawValue)
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
            private let shelf: BookshelfId
            
            public init(userId: String, shelf: BookshelfId) {
                self.userId = userId
                self.shelf = shelf
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/users/%@/bookshelves/%@/volumes", userId, shelf.rawValue)
            }
            
        }
        
    }
    
    // MARK: - MyLibrary.Bookshelves
    public struct MyLibraryBookshelvesRequest {
        
        /// GET  /mylibrary/bookshelves/{shelf}
        /// Retrieves metadata for a specific bookshelf belonging to the authenticated user.
        public struct Get: GoogleBooksApiRequest, GoogleBooksApiRequestType {
            
            public typealias Result = Bookshelf
            private let shelf: BookshelfId
            private let authToken: GoogleBooksAPIAuthToken?
            private let apiKey: GoogleBooksAPIKey?
            
            public init(shelf: BookshelfId, authToken: GoogleBooksAPIAuthToken?, apiKey: GoogleBooksAPIKey?) {
                self.shelf = shelf
                self.authToken = authToken
                self.apiKey = apiKey
            }
            
            var method: HttpMethod {
                return .get
            }
            
            var path: String {
                return String(format: "/mylibrary/bookshelves/%@", shelf.rawValue)
            }
            
            var params: [RequestParameter] {
                return apiKey.map({[("key", $0)]}) ?? []
            }
            
            var headers: [RequestHeader] {
                return authToken.map({[("Authorization", "Bearer " + $0)]}) ?? []
            }
            
        }
        
    }
    
}
