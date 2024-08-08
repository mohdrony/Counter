import SwiftUI
import AVFoundation

struct CircleTextBackground: View {
    @Binding var isAnimationOn : Bool
    @Binding var isTapped: Bool
    @Binding var isInterval1Reached : Bool
    @Binding var isInterval2Reached : Bool
    @State private var numberOfCircles: Int = 0
    private let animationDuration: TimeInterval = 2.0
    @Binding var isCountTextBlack: Bool

    var body: some View {
        ZStack {
            if isAnimationOn {
                ForEach(0..<numberOfCircles, id: \.self) { index in
                    AnimatedCircle(animationDuration: animationDuration, isCountTextBlack: $isCountTextBlack, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                }
                if isInterval2Reached || isInterval1Reached {
                        AnimatedCircle(animationDuration: animationDuration, isCountTextBlack: $isCountTextBlack, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                    }
                }
            
            Circle()
                .fill(isCountTextBlack ? Color.white : Color.black)
                .frame(width: 250, height: 250)
        }
        .onChange(of: isTapped) { _ in
                numberOfCircles += 1
        }
    }
}

struct AnimatedCircle: View {
    @State private var width: CGFloat = 250
    @State private var lineWidth: CGFloat = 0
    @State private var opacity: Double = 1.0
    @State private var endOpacity: Double = 0.0
    let animationDuration: TimeInterval
    @Binding var isCountTextBlack : Bool
    @Binding var isInterval1Reached : Bool
    @Binding var isInterval2Reached : Bool
    var body: some View {
        Circle()
            .stroke(isInterval2Reached ? .red : isInterval1Reached ? .green : (isCountTextBlack ? Color.white : Color.black), lineWidth: lineWidth)
            .frame(width: width)
            .opacity(opacity)
            .onAppear {
                startAnimation()
            }
    }

    private func startAnimation() {
        withAnimation(.easeInOut(duration: animationDuration)) {
            width = UIScreen.main.bounds.width * ((isInterval2Reached || isInterval1Reached) ? 10 : 2)
            lineWidth = (isInterval1Reached || isInterval2Reached) ? 500 : 50
            opacity = 0.0
        }
    }
}

#Preview {
    CircleTextBackground(isAnimationOn: .constant(true), isTapped: .constant(true), isInterval1Reached: .constant(true), isInterval2Reached: .constant(false), isCountTextBlack: .constant(false))
}
