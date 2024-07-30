//
//  RandomPolyTextBackground.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 28.07.24.
//

import SwiftUI

struct RandomPolyTextBackground: View {
    @Binding var isAnimationOn: Bool
    @Binding var isTapped: Bool
    @Binding var isInterval1Reached: Bool
    @Binding var isInterval2Reached: Bool
    @State private var numberOfPolygons: Int = 0
    private let animationDuration: TimeInterval = 2.0
    @Binding var isCountTextBlack: Bool
    @State var initialVertices: [CGPoint] = RandomPolygon.randomVertices(
        in: CGRect(x: 0, y: 0, width: 250, height: 250),
        centerArea: CGRect(x: 50, y: 50, width: 150, height: 150)
    )
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isAnimationOn {
                    ForEach(0..<numberOfPolygons, id: \.self) { polygon in
                        AnimatedPoly(initialVertices: initialVertices, animationDuration: animationDuration, isCountTextBlack: $isCountTextBlack, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                            .frame(width: 250, height: 250) // Set the frame to match the static polygon
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the animated polygon
                    }
                    if isInterval2Reached || isInterval1Reached {
                        AnimatedPoly(initialVertices: initialVertices, animationDuration: animationDuration, isCountTextBlack: $isCountTextBlack, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                            .frame(width: 250, height: 250) // Set the frame to match the static polygon
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the animated polygon
                    }
                }
                RandomPolygon(vertices: initialVertices)
                    .fill(isCountTextBlack ? Color.white : Color.black)
                    .frame(width: 250, height: 250)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2) // Center the static polygon
            }
            .onChange(of: isTapped) { _ in
                numberOfPolygons += 1
                addNewPolygon()
            }
        }
    }
    
    private func addNewPolygon() {
        // Generate a new polygon
        withAnimation {
            let newVertices = RandomPolygon.randomVertices(
                in: CGRect(x: 0, y: 0, width: 250, height: 250),
                centerArea: CGRect(x: 50, y: 50, width: 150, height: 150)
            )
            initialVertices = newVertices
        }
    }
}

struct AnimatedPoly: View {
    @State private var scale: CGFloat = 1.0
    @State private var lineWidth: CGFloat = 0
    @State private var opacity: Double = 1.0
    @State var initialVertices: [CGPoint]
    let animationDuration: TimeInterval
    @Binding var isCountTextBlack: Bool
    @Binding var isInterval1Reached: Bool
    @Binding var isInterval2Reached: Bool
    
    var body: some View {
        RandomPolygon(vertices: initialVertices)
            .stroke(isInterval2Reached ? .red : isInterval1Reached ? .green : (isCountTextBlack ? Color.white : Color.black), lineWidth: lineWidth)
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                startAnimation()
            }
            .frame(width: 250, height: 250) // Set the frame to match the static polygon
    }
    
    private func startAnimation() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            scale = 5.0 // Scale the polygon
            lineWidth = (isInterval2Reached || isInterval1Reached) ? 500 : 50
            opacity = 0.0 // Fade out the polygon
        }
    }
}

#Preview {
    RandomPolyTextBackground(isAnimationOn: .constant(true), isTapped: .constant(false), isInterval1Reached: .constant(true), isInterval2Reached: .constant(false), isCountTextBlack: .constant(true))
}




