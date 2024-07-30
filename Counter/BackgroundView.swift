//
//  backGround.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 28.07.24.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var isTapped: Bool
    @Binding var isVibrationOn: Bool
    @Binding var isAnimationOn : Bool
    @Binding var isFlashingColorsOn : Bool
    @Binding var selectedTheme: BackgroundTheme
    @Binding var isCountTextBlack : Bool
    @Binding var selectedColor : Color
    var body: some View {
        switch selectedTheme {
        case .animatedBWTheme:
            AnimatedBWColorBackgroundView(isTapped: $isTapped, isVibrationOn: $isVibrationOn, isAnimationOn: $isAnimationOn, isFlashingColorsOn: $isFlashingColorsOn)
        case .flashingColorTheme:
            FlashingColorBackgroundView(isTapped: $isTapped, isVibrationOn: $isVibrationOn, isFlashingColorsOn: $isFlashingColorsOn)
        case .flashingBWTheme:
            FlashingBWBackgroundView(isTapped: $isTapped, isCountTextBlack: $isCountTextBlack, isVibrationOn: $isVibrationOn, isFlashingColorsOn: $isFlashingColorsOn)
        case .colorTheme:
            SingleColorBackgroundView(isTapped: $isTapped, backgroundColor: $selectedColor, isCountTextBlack: $isCountTextBlack, isVibrationOn: $isVibrationOn)
        case .lightTheme:
            WhiteBackgroundView(isTapped: $isTapped, isCountTextBlack: .constant(false), isVibrationOn: $isVibrationOn)
        case .darkTheme:
            BlackBackgroundView(isTapped: $isTapped, isCountTextBlack: .constant(true), isVibrationOn: $isVibrationOn)
        default:
            AnimatedColorBackgroundView(isTapped: $isTapped, isVibrationOn: $isVibrationOn, isAnimationOn: $isAnimationOn, isFlashingColorsOn: $isFlashingColorsOn)
        }
    }
}


#Preview {
    BackgroundView(isTapped: .constant(false), isVibrationOn: .constant(true), isAnimationOn: .constant(true), isFlashingColorsOn: .constant(true), selectedTheme: .constant(.lightTheme), isCountTextBlack: .constant(true), selectedColor: .constant(.green))
}
