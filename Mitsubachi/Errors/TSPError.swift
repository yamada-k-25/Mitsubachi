//
//  TSPError.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/08
//  
//

import Foundation

enum TSPError: LocalizedError {
    case countMismatch(vertices: Int, edges: Int)
    
    var errorDescription: String? {
        switch self {
            case .countMismatch(let vertices, let edges):
                "The number of vertices (\(vertices)) and edges (\(edges)) does not match."
        }
    }
}
