import Foundation

public extension Tricks {
    public struct Source {
        public var markdownURL: String
        public var owner: Owner
        public var regex: String
        
        public init?(url: String, owner: Owner, regex: String) {
            guard url.trimming() != "" else {
                return nil
            }
            
            guard regex.trimming() != "" else {
                return nil
            }
            
            self.markdownURL = url
            self.owner = owner
            self.regex = regex
        }
    }
}
