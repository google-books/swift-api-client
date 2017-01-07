import Foundation

/// Represents DownloadAccessRestriction resource
public struct DownloadAccessRestriction: ValueObject {
    
    public let kind: BooksKind = BooksKind.downloadAccessRestriction
    public let volumeId: Id<Volume>
    public let restricted: Bool
    public let deviceAllowed: Bool
    public let justAcquired: Bool
    public let maxDownloadDevices: Int
    public let downloadsAcquired: Bool
    public let nonce: String
    public let source: String
    public let message: String
    public let signature: String
    
}

// MARK: - Equatable
public func ==(lhs: DownloadAccessRestriction, rhs: DownloadAccessRestriction) -> Bool {
    return lhs.kind == rhs.kind
        && lhs.volumeId == rhs.volumeId
        && lhs.restricted == rhs.restricted
        && lhs.deviceAllowed == rhs.deviceAllowed
        && lhs.justAcquired == rhs.justAcquired
        && lhs.maxDownloadDevices == rhs.maxDownloadDevices
        && lhs.downloadsAcquired == rhs.downloadsAcquired
        && lhs.nonce == rhs.nonce
        && lhs.source == rhs.source
        && lhs.message == rhs.message
        && lhs.signature == rhs.signature
}
