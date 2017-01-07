import Foundation

extension Bookshelf: Deserializable {
    
    public static func create(_ dict: [AnyHashable:Any]) -> Bookshelf? {
        guard
            let kind = dict["kind"] as? String, kind == BooksKind.bookshelf.description,
            let id = dict["id"] as? Int,
            let selfLinkString = dict["selfLink"] as? String, let selfLink = URL(string: selfLinkString),
            let title = dict["title"] as? String,
            let accessString = dict["access"] as? String, let access = Bookshelf.Access(rawValue: accessString),
            let updated = dict["updated"] as? String,
            let created = dict["created"] as? String,
            let volumeCount = dict["volumeCount"] as? Int
            else { return nil }
        let desc = dict["description"] as? String
        let volumesLastUpdated = dict["volumesLastUpdated"] as? String
        return Bookshelf(
            id: Id(String(id)),
            selfLink: selfLink,
            title: title,
            desc: desc,
            access: access,
            updated: updated,
            created: created,
            volumeCount: volumeCount,
            volumesLastUpdated: volumesLastUpdated
        )
    }
    
}
