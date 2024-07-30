//
//  CountText.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 28.07.24.
//

import SwiftUI

struct CountTextBackground: View {
    @Binding var isAnimationOn: Bool
    @Binding var isTapped: Bool
    @Binding var selectedTextBackgroundTheme: TextBackgroundTheme
    @Binding var isCountTextBlack: Bool
    @Binding var isInterval1Reached : Bool
    @Binding var isInterval2Reached : Bool
    var body: some View {
        ZStack{
            switch selectedTextBackgroundTheme {
            case .roundedRectangleTheme:
                RoundedRectangleTextBackground(isAnimationOn: $isAnimationOn, isTapped: $isTapped, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached, isCountTextBlack: $isCountTextBlack)
            case .polygonTheme:
                RandomPolyTextBackground(isAnimationOn: $isAnimationOn, isTapped: $isTapped, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached, isCountTextBlack: $isCountTextBlack)
            default:
                CircleTextBackground(isAnimationOn: $isAnimationOn, isTapped: $isTapped, isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached, isCountTextBlack: $isCountTextBlack)
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-70)
    }
}


#Preview {
    CountTextBackground(isAnimationOn: .constant(true), isTapped : .constant(false), selectedTextBackgroundTheme: .constant(.circleTextBackground), isCountTextBlack: .constant(true), isInterval1Reached: .constant(true), isInterval2Reached: .constant(false))
}
