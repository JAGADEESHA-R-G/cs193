import Foundation

enum Match: String, Codable {
    case nomatch
    case exact
    case inexact
}

enum Kind: Equatable, CustomStringConvertible {
    case master(isHidden: Bool)
    case guess
    case attempt([Match])
    case unknown

    // MARK: - CustomStringConvertible
    // This is the "Saving" logic: Enum -> String
    var description: String {
        switch self {
        case .master(let isHidden):
            return "master(\(isHidden))"
        case .guess:
            return "guess"
        case .attempt(let matches):
            // Converts [.exact, .nomatch] into "exact,nomatch"
            let matchStr = matches.map { $0.rawValue }.joined(separator: ",")
            return "attempt(\(matchStr))"
        case .unknown:
            return "unknown"
        }
    }

    // MARK: - Non-Failable Initializer
    // This is the "Loading" logic: String -> Enum
    init(_ string: String) {
        // 1. Handle "master(true/false)"
        if string.hasPrefix("master("), string.hasSuffix(")") {
            let inner = String(string.dropFirst("master(".count).dropLast())
            switch inner {
            case "true":
                self = .master(isHidden: true)
                return
            case "false":
                self = .master(isHidden: false)
                return
            default:
                break
            }
        }

        // 2. Handle "attempt(exact,nomatch)"
        if string.hasPrefix("attempt("), string.hasSuffix(")") {
            let inner = String(string.dropFirst("attempt(".count).dropLast())
            let matchStrings = inner.split(separator: ",").map(String.init)
            let matches = matchStrings.compactMap { Match(rawValue: $0) }
            self = .attempt(matches)
            return
        }

        // 3. Handle simple strings
        if string == "guess" {
            self = .guess
            return
        }

        if string == "unknown" {
            self = .unknown
            return
        }

        // Fallback for everything else
        self = .unknown
    }
}