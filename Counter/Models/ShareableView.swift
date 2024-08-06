//
//  ShareableView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 07.08.24.
//

import SwiftUI

struct ShareableView: View {
    var historyRecord: HistoryRecord
    
    var body: some View {
        ZStack{
            Rectangle().fill(.clear).frame(width: UIScreen.main.bounds.width - 25, height: UIScreen.main.bounds.width - 25)
            ZStack {
                BackgroundView(
                    isTapped: .constant(true),
                    isVibrationOn: .constant(false),
                    isAnimationOn: .constant(true),
                    isFlashingColorsOn: .constant(true),
                    selectedTheme: .constant(.animatedColorTheme),
                    isCountTextBlack: .constant(true),
                    selectedColor: .constant(.green)
                )
                .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
                
                VStack {
                    Spacer()
                    Text("\(historyRecord.name)")
                        .font(.custom("Karantina", size: 40))
                        .padding(.bottom, 25)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
                
                ZStack(alignment: .center) {
                    CircleTextBackground(
                        isAnimationOn: .constant(true),
                        isTapped: .constant(true),
                        isInterval1Reached: .constant(true),
                        isInterval2Reached: .constant(false),
                        isCountTextBlack: .constant(true)
                    )
                    Circle().fill(Color.clear)
                    AnimatedCircle(
                        animationDuration: 1,
                        isCountTextBlack: .constant(true),
                        isInterval1Reached: .constant(false),
                        isInterval2Reached: .constant(false)
                    )
                    
                    Text("\(historyRecord.count)")
                        .font(.custom("Karantina", size: 200))
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                        .frame(maxWidth: 220)
                        .foregroundColor(.black)
                }
                .scaleEffect(0.5)
                .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50)
            }
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        }
    }
}

struct ShareableView_Previews: PreviewProvider {
    static var previews: some View {
        ShareableView(historyRecord: HistoryRecord(count: 100, date: Date(), name: "Sample Record"))
    }
}

