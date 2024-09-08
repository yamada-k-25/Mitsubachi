//
//  ContentView.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/07
//  
//

import SwiftUI

@MainActor
struct ContentView: View {
    @State private var vertexListText: String = ""
    @State private var vertexOrderListText: String = ""
    @State private var error: (any Error)?
    private let tsfInputParser: TSPInputParser = .init()
    
    private var vertexList: Result<[SIMD2<Double>], Error> {
        do {
            return Result.success(
                try self.tsfInputParser
                .parseVertexes(vertexesString: self.vertexListText)
            )
        } catch {
            return Result.failure(error)
        }
    }
    
    private var vertexOrderList: Result<[Int], Error> {
        do {
            return Result.success(
                try self.tsfInputParser
                    .parseVertexOrders(vertexOrdersString: self.vertexOrderListText)
            )
        } catch {
            return Result.failure(error)
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            switch (self.vertexList, self.vertexOrderList) {
                case (.success(let vertexList), .success(let vertexOrders)):
                    if vertexList.count >= vertexOrders.count {
                        CanvasView(
                            vertexes: vertexList,
                            travelingOrder: vertexOrders
                        )
                    } else {
                        CanvasView(
                            vertexes: [],
                            travelingOrder: []
                        )
                        .overlay {
                            self.errorView(TSPError.countMismatch(
                                vertices: vertexList.count,
                                edges: vertexOrders.count
                            ))
                        }
                    }
                case (.failure(let error), _), (_, .failure(let error)):
                    CanvasView(vertexes: [], travelingOrder: [])
                        .overlay {
                            self.errorView(error)
                        }
            }
            self.inputView
                .padding(8)
        }
    }
    
    private var inputView: some View {
        VStack(alignment: .leading, spacing: 16) {
            VertexListView(vertexListText: self.$vertexListText)
            VertexOrderListView(vertexOrderListText: self.$vertexOrderListText)
        }
    }
    
    private func errorView(_ error: Error) -> some View {
        Group {
            VStack(alignment: .center, spacing: 0) {
                Text(error.localizedDescription)
            }
            .font(.body)
            .foregroundColor(.red)
        }
    }
}

#Preview {
    ContentView()
}
