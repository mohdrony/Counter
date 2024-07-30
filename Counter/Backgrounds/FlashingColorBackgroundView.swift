//
//  StaticColorBackgroundView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 25.07.24.
//

import SwiftUI
import AVFoundation

struct FlashingColorBackgroundView: View {
    @Binding var isTapped: Bool
    @State private var backgroundColor: Color = .yellow
    @Binding var isVibrationOn : Bool
    @Binding var isFlashingColorsOn : Bool
    
    var body: some View {
        backgroundColor
            .edgesIgnoringSafeArea(.all)
            .onChange(of: isTapped) {
                tapActions()
            }
    }
    
    private func tapActions() {
        if isFlashingColorsOn{
            backgroundColor = generateRandomColor()
        }
        if isVibrationOn{
            triggerHapticFeedback()
        }
    }

    private func generateRandomColor() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
}

#Preview {
    FlashingColorBackgroundView(isTapped: .constant(false), isVibrationOn: .constant(true), isFlashingColorsOn: .constant(true))
}
