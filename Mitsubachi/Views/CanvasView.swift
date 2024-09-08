//
//  CanvasView.swift
//  Mitsubachi
//  
//  Created by yamada-k-25 on 2024/09/08
//  
//

import SwiftUI

@MainActor
struct CanvasView {
    let vertexes: [SIMD2<Double>]
    let travelingOrder: [Double]
    
    private var maxX: Double? {
        self.vertexes.max(by: { lhs, rhs in lhs.x < rhs.x })?.x
    }
    private var maxY: Double? {
        self.vertexes.max(by: { lhs, rhs in lhs.y < rhs.y })?.y
    }
    private var minX: Double? {
        self.vertexes.max(by: { lhs, rhs in lhs.x > rhs.x })?.x
    }
    private var minY: Double? {
        self.vertexes.max(by: { lhs, rhs in lhs.y > rhs.y })?.y
    }
    
    // MARK: Display area style's properties and methods.
    
    private let displayInsetRatio: CGFloat = 0.10
    
    private func displayInset(canvasSize: CGSize) -> CGFloat {
        min(canvasSize.width, canvasSize.height) * self.displayInsetRatio
    }
    
    private func displayAreaSize(canvasSize: CGSize) -> CGSize {
        .init(
            width: canvasSize.width - self.displayInset(canvasSize: canvasSize) * 2,
            height: canvasSize.height - self.displayInset(canvasSize: canvasSize) * 2
        )
    }
    
    private func displayVertexes(canvasSize: CGSize) -> [SIMD2<Double>] {
        self.normalizedVertexes.map {
            let displayAreaSize = self.displayAreaSize(canvasSize: canvasSize)
            let displayInset = self.displayInset(canvasSize: canvasSize)
            let (width, height) = (displayAreaSize.width, displayAreaSize.height)
            
            return SIMD2<Double>.init(
                width * $0.x + displayInset,
                height * $0.y + displayInset
            )
        }
    }

    private var normalizedVertexes: [SIMD2<Double>] {
        guard let maxX, let minX, let maxY, let minY else {
            return []
        }
        
        return self.vertexes
            .map {
                SIMD2<Double>.init(
                    ($0.x - minX)/(maxX - minX),
                    ($0.y - minY)/(maxY - minY)
                )
            }
    }
}

extension CanvasView: View {
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Canvas { context, size in
                    for (num, vertex) in self
                        .displayVertexes(canvasSize: proxy.size)
                        .enumerated() {
                        self.drawVertex(
                            context: context,
                            x: vertex.x,
                            y: vertex.y,
                            number: num
                        )
                    }
                }
                .background(.white)
                .overlay(alignment: .bottom) {
                    Text(
                        "width: \(proxy.size.width), height: \(proxy.size.height)"
                    )
                    .foregroundStyle(.blue)
                    .font(.caption)
                    .backgroundStyle(.clear)
                }
            }
        }
    }
    
    private func drawVertex(context: GraphicsContext, x: CGFloat, y: CGFloat, number: Int) {
        let vertexSize: CGFloat = 20
        let rect = CGRect(
            origin: .init(
                x: x - vertexSize/2,
                y: y - vertexSize/2
            ),
            size: .init(width: vertexSize, height: vertexSize)
        )
        
        context.stroke(
            Path(
                ellipseIn: rect
            ),
            with: .color(.green),
            lineWidth: 2
        )
        context.draw(
            Text("\(number)")
                .font(.body)
                .foregroundStyle(.green),
            at: CGPoint(x: x, y: y)
        )
    }
}
