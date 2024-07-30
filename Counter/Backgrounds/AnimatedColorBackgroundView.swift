//
//  AnimatedBackgroundView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 25.07.24.
//

import SwiftUI
import AVFoundation

struct AnimatedColorBackgroundView: View {
    @Binding var isTapped: Bool
    @Binding var isVibrationOn: Bool
    @Binding var isAnimationOn : Bool
    @Binding var isFlashingColorsOn : Bool
    @State private var gradientColors: [Color] = [.red, .blue]
    @State private var startPoint = UnitPoint.topLeading
    @State private var endPoint = UnitPoint.bottomTrailing
    @State private var timer: Timer?

    var body: some View {
        LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: startPoint, endPoint: endPoint)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 100)
            .onChange(of: isTapped) {
                tapActions()
            }
            .onAppear {
                if isAnimationOn{
                    startContinuousAnimation()
                }
            }
            .onDisappear {
                stopContinuousAnimation()
            }
    }

    private func tapActions() {
        if isFlashingColorsOn{
            generateRandomGradient()
        }
        if isVibrationOn {
            triggerHapticFeedback()
        }
    }

    private func generateRandomGradient() {
        gradientColors = [generateRandomColor(), generateRandomColor()]
    }

    private func generateRandomColor() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    private func startContinuousAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 3)) {
                startPoint = UnitPoint.random()
                endPoint = UnitPoint.random()
            }
        }
    }

    private func stopContinuousAnimation() {
        timer?.invalidate()
    }
}

extension UnitPoint {
    static func random() -> UnitPoint {
        return UnitPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1))
    }
}



#Preview {
    AnimatedColorBackgroundView(isTapped: .constant(false), isVibrationOn: .constant(true), isAnimationOn: .constant(true), isFlashingColorsOn: .constant(true))
}
