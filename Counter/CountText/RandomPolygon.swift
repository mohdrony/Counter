//
//  RandomPolygon.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 25.07.24.
//

import SwiftUI

struct RandomPolygon: Shape {
    var vertices: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard vertices.count > 1 else { return path }

        path.move(to: vertices[0])
        for vertex in vertices.dropFirst() {
            path.addLine(to: vertex)
        }
        path.closeSubpath()

        return path
    }

    static func randomVertices(in rect: CGRect, centerArea: CGRect) -> [CGPoint] {
        return [
            CGPoint(x: CGFloat.random(in: rect.minX...centerArea.minX), y: CGFloat.random(in: rect.minY...centerArea.minY)),
            CGPoint(x: CGFloat.random(in: centerArea.maxX...rect.maxX), y: CGFloat.random(in: rect.minY...centerArea.minY)),
            CGPoint(x: CGFloat.random(in: centerArea.maxX...rect.maxX), y: CGFloat.random(in: centerArea.maxY...rect.maxY)),
            CGPoint(x: CGFloat.random(in: rect.minX...centerArea.minX), y: CGFloat.random(in: centerArea.maxY...rect.maxY))
        ]
    }
}

#Preview {
    RandomPolygon(vertices: RandomPolygon.randomVertices(
        in: CGRect(x: 0, y: 0, width: 250, height: 250),
        centerArea: CGRect(x: 50, y: 50, width: 150, height: 150)
    ))
}

