import Foundation

private extension String {
    func trimming() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

public extension Tricks {
    public struct Tip {
        public var issue: Int?
        public var title: String?
        public var tweet: String?
        public var description: String?
        public var code: String?
        public var comments: [Comment]?
        
        init?(_ content: NSString, match: NSTextCheckingResult) {
            var issueRange: NSRange?
            var titleRange: NSRange?
            var tweetRange: NSRange?
            var descriptionRange: NSRange?
            var codeRange: NSRange?
            var commentsRange: NSRange?
            
            if #available(OSX 10.13, *) {
                issueRange          = match.range(withName: "issue")
                titleRange          = match.range(withName: "title")
                tweetRange          = match.range(withName: "tweet")
                descriptionRange    = match.range(withName: "description")
                codeRange           = match.range(withName: "code")
                commentsRange       = match.range(withName: "comments")
            }
            else {
                let ranges          = match.numberOfRanges
                issueRange          = ranges >= 2 ? match.range(at: 1) : nil
                titleRange          = ranges >= 3 ? match.range(at: 2) : nil
                tweetRange          = ranges >= 4 ? match.range(at: 3) : nil
                descriptionRange    = ranges >= 5 ? match.range(at: 4) : nil
                codeRange           = ranges >= 6 ? match.range(at: 5) : nil
                commentsRange       = ranges >= 7 ? match.range(at: 6) : nil
            }
            
            if let range = issueRange, range.location != NSNotFound, range.length > 0, let number = Int(content.substring(with: range)) {
                issue = number
            }
            
            if let range = titleRange, range.location != NSNotFound, range.length > 0 {
                title = content.substring(with: range).trimming()
            }
            
            if let range = tweetRange, range.location != NSNotFound, range.length > 0 {
                tweet = content.substring(with: range)
            }
            
            if let range = descriptionRange, range.location != NSNotFound, range.length > 0 {
                description = content.substring(with: range).trimming()
            }
            
            if let range = codeRange, range.location != NSNotFound, range.length > 0 {
                code = content.substring(with: range).trimming()
            }
            
            if let range = commentsRange, range.location != NSNotFound, range.length > 0 {
                let values = content.substring(with: range).components(separatedBy: .newlines)
                
                if values.count > 0 {
                    comments = values.flatMap({ Comment($0.trimming()) })
                }
            }
        }
    }
}
