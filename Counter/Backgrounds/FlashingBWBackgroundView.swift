//
//  BlackAndWhiteBackgroundView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 25.07.24.
//

import SwiftUI
import AVFoundation


struct FlashingBWBackgroundView: View {
    @Binding var isTapped: Bool
    @State private var backgroundColor: Color = .white
    @Binding var isCountTextBlack: Bool
    @Binding var isVibrationOn: Bool
    @Binding var isFlashingColorsOn: Bool
    
    var body: some View {
        backgroundColor
            .edgesIgnoringSafeArea(.all)
            .onChange(of: isTapped) {
                tapActions()
            }
    }
    
    private func tapActions() {
        if isFlashingColorsOn{
            if backgroundColor == .white {
                backgroundColor = .black
                isCountTextBlack = true
            } else {
                backgroundColor = .white
                isCountTextBlack = false
            }
        } else {
            backgroundColor = .white
            isCountTextBlack = false
        }
        if isVibrationOn{
            triggerHapticFeedback()
        }
    }

    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

#Preview {
    FlashingBWBackgroundView(isTapped: .constant(false), isCountTextBlack: .constant(true), isVibrationOn: .constant(true), isFlashingColorsOn: .constant(true))
}


