//
//  TSPInputParser.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/08
//  
//

struct TSPInputParser {
    func parseVertexes(vertexesString: String) throws -> [SIMD2<Double>] {
        var vertexes: [SIMD2<Double>] = []
        
        for (num, line) in vertexesString.split(separator: "\n").enumerated() {
            let xy = line.split(separator: " ")
            guard xy.count == 2 else {
                throw ParsingError
                    .invalidLineFormat(
                        reason: .invalidInputCountOnLine,
                        line: String(line),
                        lineNumber: num
                    )
            }
            
            guard let x = Double(String(xy[0])), let y = Double(String(xy[1])) else {
                throw ParsingError
                    .invalidLineFormat(
                        reason: .noDoubleeger,
                        line: String(line),
                        lineNumber: num
                    )
            }
            
            vertexes.append(.init(x, y))
        }
        
        return vertexes
    }
    
    func parseVertexOrders(vertexOrdersString: String) throws -> [Int] {
        var orders: [Int] = []
        
        for (num, line) in vertexOrdersString
            .split(separator: "\n")
            .enumerated() {
            
            guard line.split(separator: " ").count == 1 else {
                throw ParsingError
                    .invalidLineFormat(
                        reason: .invalidInputCountOnLine,
                        line: String(line),
                        lineNumber: num
                    )
            }
            guard let order = Int(String(line)) else {
                throw ParsingError
                    .invalidLineFormat(
                        reason: .noInt,
                        line: String(line),
                        lineNumber: num
                    )
            }
            
            orders.append(order)
        }
        
        return orders
    }
}
