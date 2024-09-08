//
//  ParsingError.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/08
//  
//

import Foundation.NSError

enum ParsingError: Error {
    case invalidLineFormat(reason: Reason, line: String, lineNumber: Int)
}

extension ParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .invalidLineFormat(let reason, let line, let lineNumber):
                return "\(reason.rawValue)\nline: \(lineNumber), `\(line)`"
        }
    }
}

enum Reason: String {
    case invalidInputCountOnLine = "you must input data formatting `x y` on every line."
    case noDoubleeger = "failed to parse to `Double`."
    case noInt = "failed to parse to `Int`."
}
