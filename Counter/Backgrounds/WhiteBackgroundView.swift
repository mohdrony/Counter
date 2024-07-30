//
//  WhiteBackgroundView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 31.07.24.
//

import SwiftUI

struct WhiteBackgroundView: View {
    @Binding var isTapped: Bool
    @State private var backgroundColor: Color = .white
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
    WhiteBackgroundView(isTapped: .constant(false), isCountTextBlack: .constant(false), isVibrationOn: .constant(true))
}
