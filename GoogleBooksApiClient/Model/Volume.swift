import Foundation

public struct Volumes {
    
    public let kind: BooksKind = BooksKind.volumes
    public let totalItems: Int?
    public let items: [Volume]
    
}

/// Represents Volume resource
/// https://developers.google.com/books/docs/v1/reference/volumes#resource
public struct Volume: Entity {
    
    public let kind: BooksKind = BooksKind.volume
    public let id: Id<Volume>
    public let etag: String
    public let selfLink: URL
    public let volumeInfo: VolumeInfo
    public let userInfo: UserInfo?
    public let saleInfo: SaleInfo?
    public let accessInfo: AccessInfo?
    public let searchInfo: SearchInfo?
    
    public struct VolumeInfo: ValueObject {
        
        public let title: String
        public let subtitle: String?
        public let authors: [String]
        public let publisher: String?
        public let publishedDate: String?
        public let desc: String?
        public let industryIdentifiers: [IndustryIdentifer]
        public let pageCount: Int?
        public let dimensions: Dimensions?
        public let printType: String?
        public let mainCategory: String?
        public let categories: [String]
        public let averageRating: Double?
        public let ratingsCount: Int?
        public let contentVersion: String?
        public let imageLinks: ImageLinks?
        public let language: String?
        public let previewLink: URL?
        public let infoLink: URL?
        public let canonicalVolumeLink: URL?
        
        public struct IndustryIdentifer: ValueObject {
            
            public let type: String
            public let identifier: String
            
        }
        
        public struct Dimensions: ValueObject {
            
            public let height: String?
            public let width: String?
            public let thickness: String?
            
        }
        
        public struct ImageLinks: ValueObject {
            
            public let smallThumbnail: URL?
            public let thumbnail: URL?
            public let small: URL?
            public let medium: URL?
            public let large: URL?
            public let extraLarge: URL?
            
        }
        
    }
    
    public struct UserInfo: ValueObject {
        
        public let isPurchased: Bool?
        public let isPreorderd: Bool?
        public let updated: Date
        
    }
    
    public struct SaleInfo: ValueObject {
        
        public let country: String
        public let saleability: String
        public let onSaleDate: Date
        public let isEbook: Bool
        public let listPrice: Price
        public let retailPrice: Price
        public let buyLink: URL
        
        public struct Price {
            
            public let amount: Double
            public let currencyCode: String
            
        }
        
    }
    
    public struct AccessInfo: ValueObject {
        
        public let country: String
        public let viewability: String
        public let embeddable: Bool
        public let publicDomain: Bool
        public let textToSpeechPermission: String
        public let epub: Details
        public let pdf: Details
        public let webReaderLink: URL
        public let accessViewStatus: String
        public let downloadAccess: DownloadAccessRestriction
        
        public struct Details: ValueObject {
            
            public let isAvailable: Bool
            public let downloadLink: URL
            public let acsTokenLink: URL
            
        }
        
    }

    public struct SearchInfo: ValueObject {
        
        public let textSnippet: String
        
    }
    
}

// MARK: - Equatable
public func ==(lhs: Volume, rhs: Volume) -> Bool {
    return lhs.kind == rhs.kind
        && lhs.id == rhs.id
        && lhs.etag == rhs.etag
        && lhs.selfLink == rhs.selfLink
        && lhs.volumeInfo == rhs.volumeInfo
        && lhs.userInfo == rhs.userInfo
        && lhs.saleInfo == rhs.saleInfo
        && lhs.accessInfo == rhs.accessInfo
        && lhs.searchInfo == rhs.searchInfo
}

public func ==(lhs: Volume.VolumeInfo, rhs: Volume.VolumeInfo) -> Bool {
    return lhs.title == rhs.title
        && lhs.subtitle == rhs.subtitle
        && lhs.authors == rhs.authors
        && lhs.publisher == rhs.publisher
        && lhs.publishedDate == rhs.publishedDate
        && lhs.desc == rhs.desc
        && lhs.industryIdentifiers == rhs.industryIdentifiers
        && lhs.pageCount == rhs.pageCount
        && lhs.dimensions == rhs.dimensions
        && lhs.printType == rhs.printType
        && lhs.mainCategory == rhs.mainCategory
        && lhs.categories == rhs.categories
        && lhs.averageRating == rhs.averageRating
        && lhs.ratingsCount == rhs.ratingsCount
        && lhs.contentVersion == rhs.contentVersion
        && lhs.imageLinks == rhs.imageLinks
        && lhs.language == rhs.language
        && lhs.previewLink == rhs.previewLink
        && lhs.infoLink == rhs.infoLink
        && lhs.canonicalVolumeLink == rhs.canonicalVolumeLink
}

public func ==(lhs: Volume.VolumeInfo.IndustryIdentifer, rhs: Volume.VolumeInfo.IndustryIdentifer) -> Bool {
    return lhs.identifier == rhs.identifier
        && lhs.type == rhs.type
}

public func ==(lhs: Volume.VolumeInfo.Dimensions, rhs: Volume.VolumeInfo.Dimensions) -> Bool {
    return lhs.height == rhs.height
        && lhs.width == rhs.width
        && lhs.thickness == rhs.thickness
}

public func ==(lhs: Volume.VolumeInfo.ImageLinks, rhs: Volume.VolumeInfo.ImageLinks) -> Bool {
    return lhs.smallThumbnail == rhs.smallThumbnail
        && lhs.thumbnail == rhs.thumbnail
        && lhs.small == rhs.small
        && lhs.medium == rhs.medium
        && lhs.large == rhs.large
        && lhs.extraLarge == rhs.large
}

public func ==(lhs: Volume.UserInfo, rhs: Volume.UserInfo) -> Bool {
    return lhs.isPurchased == rhs.isPurchased
        && lhs.isPreorderd == rhs.isPreorderd
        && lhs.updated == rhs.updated
}

public func ==(lhs: Volume.SaleInfo, rhs: Volume.SaleInfo) -> Bool {
    return lhs.country == rhs.country
        && lhs.saleability == rhs.saleability
        && lhs.onSaleDate == rhs.onSaleDate
        && lhs.isEbook == rhs.isEbook
        && lhs.listPrice == rhs.listPrice
        && lhs.retailPrice == rhs.retailPrice
        && lhs.buyLink == rhs.buyLink
}

public func ==(lhs: Volume.SaleInfo.Price, rhs: Volume.SaleInfo.Price) -> Bool {
    return lhs.amount == rhs.amount
        && lhs.currencyCode == rhs.currencyCode
}

public func ==(lhs: Volume.AccessInfo, rhs: Volume.AccessInfo) -> Bool {
    return lhs.country == rhs.country
        && lhs.viewability == rhs.viewability
        && lhs.embeddable == rhs.embeddable
        && lhs.publicDomain == rhs.publicDomain
        && lhs.textToSpeechPermission == rhs.textToSpeechPermission
        && lhs.epub == rhs.epub
        && lhs.pdf == rhs.pdf
        && lhs.webReaderLink == rhs.webReaderLink
        && lhs.accessViewStatus == rhs.accessViewStatus
        && lhs.downloadAccess == rhs.downloadAccess
}

public func ==(lhs: Volume.AccessInfo.Details, rhs: Volume.AccessInfo.Details) -> Bool {
    return lhs.isAvailable == rhs.isAvailable
        && lhs.downloadLink == rhs.downloadLink
        && lhs.acsTokenLink == rhs.acsTokenLink
}

public func ==(lhs: Volume.SearchInfo, rhs: Volume.SearchInfo) -> Bool {
    return lhs.textSnippet == rhs.textSnippet
}
