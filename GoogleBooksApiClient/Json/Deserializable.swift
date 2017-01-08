import Foundation

public protocol Deserializable {
    
    static func create(_ dict: [AnyHashable:Any]) -> Self?
    
}
