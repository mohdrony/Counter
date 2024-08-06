//
//  ContentView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 25.07.24.
//

import SwiftUI
import AVFoundation
import Combine

struct ContentView: View {
    @State private var count = 0
    @State private var isCountTextBlack = true
    
    @State private var interval1: Int = 10
    @State private var interval2: Int = 100
    @State private var isInterval1Reached = false
    @State private var isInterval2Reached = false
    @State private var isVibrationOn = true
    @State private var isAnimationOn = true
    @State private var isFlashingColorsOn = true
    @State private var selectedColor : Color = .green
    
    @State var isTapped = false
    @State private var selectedTheme: BackgroundTheme = .animatedColorTheme
    @State private var selectedTextBackgroundTheme: TextBackgroundTheme = .circleTextBackground
    @State private var volumeObserver: AnyCancellable?
        
    @State private var showSpecialAnimation = false
    @State private var specialAnimationOpacity: Double = 0.0
    @State private var vibrationIntensity: UIImpactFeedbackGenerator.FeedbackStyle = .light
    
    @State private var isSettingSheetShowing: Bool = false
    
    @State private var isHistoryViewShowing: Bool = false
    @State private var historyRecords: [HistoryRecord] = []

    var body: some View {
        ZStack{
            
            ZStack {
                BackgroundView(isTapped: $isTapped, isVibrationOn: $isVibrationOn, isAnimationOn: $isAnimationOn, isFlashingColorsOn: $isFlashingColorsOn, selectedTheme: $selectedTheme, isCountTextBlack: $isCountTextBlack, selectedColor: $selectedColor)
                    
                
                ZStack {
                    CountTextBackground(isAnimationOn: $isAnimationOn, isTapped: $isTapped, selectedTextBackgroundTheme: $selectedTextBackgroundTheme, isCountTextBlack: (selectedTheme == .lightTheme ? .constant(false) : $isCountTextBlack), isInterval1Reached: $isInterval1Reached, isInterval2Reached: $isInterval2Reached)
                    Text("\(count)")
                        .font(.custom("Karantina", size: 200)).minimumScaleFactor(0.2).lineLimit(1).frame(maxWidth: 220)
                        .foregroundColor((selectedTheme == .lightTheme) ? .white : (isCountTextBlack ? .black : .white))
                }
            }
            .onTapGesture {
                mainTapActions()
            }
            
            VStack{
            HStack {
                Button(action: {
                    resetCount()
                }) {
                    ZStack(alignment: .center) {
                        Circle().fill(.clear).frame(width: 65)
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor((selectedTheme == .lightTheme || !isCountTextBlack) ? .black : .white)
                            .overlay {
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .foregroundColor(.green)
                            }.frame(height: 40)
                    }
                }
                Spacer()
                HStack{
                    Button(action: {
                        isSettingSheetShowing.toggle()
                    }) {
                        ZStack {
                            Image(systemName: "info.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor((selectedTheme == .lightTheme || !isCountTextBlack) ? .black : .white)
                        }
                        .frame(height: 40)
                    }
                    Button(action: {
                        isHistoryViewShowing.toggle()
                    }) {
                        ZStack {
                            Image(systemName: "arrow.up.right.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor((selectedTheme == .lightTheme || !isCountTextBlack) ? .black : .white)
                        }
                        .frame(height: 40)
                    }
                }.padding(.trailing, 11)
                
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width)
                Spacer()
        }
        }
        .onChange(of: count) { newValue in
            checkIntervals(newValue)
        }
        .onAppear{
            loadHistory()
        }
        .onDisappear {
            volumeObserver?.cancel()
        }
        .sheet(isPresented: $isSettingSheetShowing) {
            SettingsView(
                isSettingViewShowing: $isSettingSheetShowing,
                isHistoryViewShowing: $isHistoryViewShowing, selectedTheme: $selectedTheme,
                selectedTextBackgroundTheme: $selectedTextBackgroundTheme,
                interval1: $interval1,
                interval2: $interval2,
                isVibrationOn: $isVibrationOn,
                isAnimationOn: $isAnimationOn,
                isFlashingColorsOn: $isFlashingColorsOn, selectedColor: $selectedColor
            )
        }
        .sheet(isPresented: $isHistoryViewShowing) {
            HistoryView(historyRecords: $historyRecords, count: $count)
                }
    }

    private func resetCount() {
            let newRecord = HistoryRecord(count: count, date: Date(), name: "Record \(historyRecords.count + 1)")
            historyRecords.append(newRecord)
            saveHistory()
            count = 0
        }

    private func mainTapActions() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
        } catch {
            print("Failed to activate AVAudioSession")
        }

        volumeObserver = session.publisher(for: \.outputVolume)
            .sink { _ in
                count += 1
                isTapped.toggle()
            }
    }

    private func checkIntervals(_ newValue: Int) {
        if newValue % interval1 == 0 {
            if isVibrationOn{
                triggerSpecialEffects1()
            }
            isInterval1Reached = true
        } else if newValue % interval2 == 0 {
            if isVibrationOn{
                triggerSpecialEffects2()
            }
            isInterval2Reached = true
        } else {
            isInterval1Reached = false
            isInterval2Reached = false
        }
    }

    private func triggerSpecialEffects1() {
        withAnimation(.easeInOut(duration: 1.0)) {
            specialAnimationOpacity = 0.5
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                specialAnimationOpacity = 1.0
            }
        }

        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    generator.impactOccurred()
                }
    }
    private func triggerSpecialEffects2() {
        withAnimation(.easeInOut(duration: 1.0)) {
            specialAnimationOpacity = 0.5
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            withAnimation(.easeInOut(duration: 1.0)) {
                specialAnimationOpacity = 1.0
            }
        }

        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    generator.impactOccurred()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    generator.impactOccurred()
                }
    }
    
    
    private func saveHistory() {
            if let encoded = try? JSONEncoder().encode(historyRecords) {
                UserDefaults.standard.set(encoded, forKey: "historyRecords")
            }
        }

        private func loadHistory() {
            if let data = UserDefaults.standard.data(forKey: "historyRecords"),
               let decoded = try? JSONDecoder().decode([HistoryRecord].self, from: data) {
                historyRecords = decoded
            }
        }
}


#Preview {
    ContentView()
}


