import Foundation

public extension Tricks {
    public struct Owner {
        public var name: String
        public var github: String
        public var twitter: String
        
        public init?(name: String, github: String, twitter: String) {
            guard name.trimming() != "" else {
                return nil
            }
            
            guard github.trimming() != "" else {
                return nil
            }
            
            guard twitter.trimming() != "" else {
                return nil
            }
            
            self.name = name
            self.github = github
            self.twitter = twitter
        }
    }
}
