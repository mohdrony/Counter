//
//  RoundedRectangleTextBackground.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 28.07.24.
//

import SwiftUI

struct RoundedRectangleTextBackground: View {
    @Binding var isAnimationOn : Bool
    @Binding var isTapped: Bool
    @Binding var isInterval1Reached : Bool
    @Binding var isInterval2Reached : Bool
    @State private var numberOfRectangles: Int = 0
    private let animationDuration: TimeInterval = 2.0
    @Binding var isCountTextBlack: Bool

    var body: some View {
        ZStack{
            if isAnimationOn {
                ForEach(0..<numberOfRectangles, id: \.self) { index in
                    AnimatedRoundedRectangle(animationDuration: animationDuration, isCountTextBlack: $isCountTextBlack, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                    
                }
                if isInterval2Reached || isInterval1Reached {
                    AnimatedRoundedRectangle(animationDuration: animationDuration, isCountTextBlack: $isCountTextBlack, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                }
            }
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(isCountTextBlack ? Color.white : Color.black)
                .frame(width: 250, height: 250)
        }.onChange(of: isTapped) { _ in
            numberOfRectangles += 1
        }
    }
}

#Preview {
    RoundedRectangleTextBackground(isAnimationOn: .constant(true), isTapped: .constant(true), isInterval1Reached: .constant(true), isInterval2Reached: .constant(false), isCountTextBlack: .constant(true))
}

struct AnimatedRoundedRectangle: View {
    @State private var width: CGFloat = 250
    @State private var height: CGFloat = 250
    @State private var lineWidth: CGFloat = 0
    @State private var opacity: Double = 1.0
    let animationDuration: TimeInterval
    @Binding var isCountTextBlack : Bool
    @Binding var isInterval1Reached : Bool
    @Binding var isInterval2Reached : Bool

    var body: some View {
        RoundedRectangle(cornerRadius: width/10)
            .stroke(isInterval2Reached ? .red : isInterval1Reached ? .green : (isCountTextBlack ? Color.white : Color.black), lineWidth: lineWidth)
            .frame(width: width, height: height)
            .opacity(opacity)
            .onAppear {
                startAnimation()
            }
    }

    private func startAnimation() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            width = UIScreen.main.bounds.width * ((isInterval1Reached || isInterval2Reached) ? 5 : 2)
            height = UIScreen.main.bounds.height * ((isInterval1Reached || isInterval2Reached) ? 5 : 2)
            lineWidth = (isInterval1Reached || isInterval2Reached) ? 1000 : 50
            opacity = 0.0
        }
    }
}
