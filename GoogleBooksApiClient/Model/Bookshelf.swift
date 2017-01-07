import Foundation

/// Represents Bookshelf resource
/// https://developers.google.com/books/docs/v1/reference/bookshelves#resource
public struct Bookshelf: Entity {
    
    public let kind: BooksKind = BooksKind.bookshelf
    public let id: Id<Bookshelf>
    public let selfLink: URL
    public let title: String
    public let desc: String
    public let access: String
    public let updated: Date
    public let created: Date
    public let volumeCount: Int
    public let volumesLastUpdated: Date
    
}

// MARK: - Equatable
extension Bookshelf: Equatable {}
public func ==(lhs: Bookshelf, rhs: Bookshelf) -> Bool {
    return lhs.kind == rhs.kind
        && lhs.id == rhs.id
        && lhs.selfLink == rhs.selfLink
        && lhs.title == rhs.title
        && lhs.desc == rhs.desc
        && lhs.access == rhs.access
        && lhs.updated == rhs.updated
        && lhs.created == rhs.created
        && lhs.volumeCount == rhs.volumeCount
        && lhs.volumesLastUpdated == rhs.volumesLastUpdated
}
