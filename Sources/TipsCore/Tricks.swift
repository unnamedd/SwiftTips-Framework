import Foundation

public final class Tricks {
    // MARK: - Private properties
    private var source: Source
    
    // MARK: - Public properties
    public typealias TipsClosure = (_ tips: [Tip]) -> Void
    public var tips: [Tip]?
    
    public init(from source: Source) {
        self.source = source
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
    
    private func parse(_ text: String) -> [Tip] {
        let results: [NSTextCheckingResult] = matches(for: source.regex, in: text)
        let content = text as NSString
        
        let tips = results.flatMap { Tip(content, match: $0) }
        self.tips = tips
        
        return tips
    }
    
    // MARK: - Public methods
    public func read(_ completion: TipsClosure?) {
        GithubService.markdown(from: source) { [unowned self] result in
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
