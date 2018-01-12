import Foundation

final class Tricks {
    // MARK: - Private properties
    private let regex = "## \\[\\#(?<issue>[0-9]+) (?<title>[^\\]]+)]\\((?<tweet>[^\\)]*)\\)\\n(?<description>[\\s\\S]*?)```swift\\n(?<code>[\\s\\S]*?)\\n```\\n*(?<comments>[^#]+)"
    private var origin: Origin
    
    // MARK: - Public properties
    typealias CompletionTips = (_ tips: [Tip]) -> Void
    
    static let main = Tricks(from: .remote)
    var content: [Tip]?
    
    enum Origin {
        case local
        case remote
    }
    
    // MARK: - Initialization
    init(from: Origin) {
        origin = from
    }
    
    convenience init() {
        self.init(from: .remote)
    }
    
    // MARK: - Private methods
    private func matches(for regex: String, in text: String) -> [NSTextCheckingResult] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let range = NSRange(text.startIndex...,  in: text)
            
            return regex.matches(in: text, range: range)
        }
        catch let error {
            print("Invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    private func parse(_ listTips: String) -> [Tip] {
        let results: [NSTextCheckingResult] = matches(for: regex, in: listTips)
        let content = listTips as NSString
        
        let tips = results.flatMap { Tip(content, match: $0) }
        self.content = tips
        
        return tips
    }
    
    // MARK: - Public methods
    public func read(_ completion: CompletionTips?) {
        switch origin {
        case .local:
            guard let dirPath = URL(string: "file:///Users/unnamedd/workspace/opensource/tips/Sources/tips/tips.md") else {
                return
            }
            
            guard let content = try? String(contentsOf: dirPath, encoding: .utf8) else {
                fatalError("File could not be parsed")
            }
            
            completion?(parse(content))
            
        case .remote:
            GithubService.markdown { [unowned self] result in
                guard let tips = result.value else {
                    if let error = result.error {
                        print("Error: \(error)")
                    }
                    return
                }

                completion?(self.parse(tips))
            }
        }
    }
}
