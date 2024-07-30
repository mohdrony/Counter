//
//  BlackBackgroundView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 31.07.24.
//

import SwiftUI

struct BlackBackgroundView: View {
    
    @Binding var isTapped: Bool
    @State private var backgroundColor: Color = .black
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
    BlackBackgroundView(isTapped: .constant(false), isCountTextBlack: .constant(true), isVibrationOn: .constant(true))
}
