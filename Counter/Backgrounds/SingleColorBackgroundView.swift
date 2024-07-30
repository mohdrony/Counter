//
//  SingleColorBackgroundView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 31.07.24.
//

import SwiftUI

struct SingleColorBackgroundView: View {
    @Binding var isTapped: Bool
    @Binding var backgroundColor: Color
    @Binding var isCountTextBlack: Bool
    @Binding var isVibrationOn: Bool
    var body: some View {
        backgroundColor
            .edgesIgnoringSafeArea(.all)
            .onChange(of: isTapped) {
                tapActions()
            }
    }
    
    private func tapActions() {
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
    SingleColorBackgroundView(isTapped: .constant(false), backgroundColor: .constant(.green), isCountTextBlack: .constant(true), isVibrationOn: .constant(true))
}
