import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isSettingViewShowing: Bool
    @Binding var isHistoryViewShowing: Bool

    @Binding var selectedTheme: BackgroundTheme
    @Binding var selectedTextBackgroundTheme: TextBackgroundTheme
    @Binding var interval1: Int
    @Binding var interval2: Int
    @Binding var isVibrationOn: Bool
    @Binding var isAnimationOn: Bool
    @Binding var isFlashingColorsOn : Bool
    
    @Binding var selectedColor : Color
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Set Checkpoints")) {
                    IntervalSelectionButton(interval1: $interval1, interval2: $interval2)
                }
                
                Section(header: Text("Set the Mood")) {
                    Picker("Background", selection: $selectedTheme) {
                        ForEach(BackgroundTheme.backgroundThemes, id: \.self) { theme in
                            Text(theme.themeName).tag(theme)
                        }
                    }.pickerStyle(.menu)
                    
                    Picker("Text Background", selection: $selectedTextBackgroundTheme) {
                        ForEach(TextBackgroundTheme.textBackgroundThemes, id: \.self) { theme in
                            Text(theme.textBackgroundThemeName).tag(theme)
                        }
                    }.pickerStyle(.menu)
                    if selectedTheme == .colorTheme{
                        ColorPicker("Select Color", selection: $selectedColor)
                    }
                }
                    Section(header: Text("Set your Preferences")) {
                            Toggle("Vibration", isOn: $isVibrationOn)
                            Toggle("Animation", isOn: $isAnimationOn)
                            Toggle("Flashing Background", isOn: $isFlashingColorsOn)
//
//                            Image(systemName: "iphone.gen2.radiowaves.left.and.right.circle.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(isVibrationOn ? .green : .gray)
//                                .onTapGesture {
//                                    isVibrationOn.toggle()
//                                }
//                                .padding(.horizontal, 10)
//                            Image(systemName: "camera.filters")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(isAnimationOn ? .green : .gray)
//                                .onTapGesture {
//                                    isAnimationOn.toggle()
//                                }
//                            Image(systemName: "slowmo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 30, height: 30)
//                                .foregroundColor(isFlashingColorsOn ? .green : .gray)
//                                .onTapGesture {
//                                    isFlashingColorsOn.toggle()
//                                }
                    }
                    
                    Section(header: Text("About Us")) {
                        Link("Please Rate Us", destination: URL(string: "https://apps.apple.com/de/app/einb%C3%BCrgerungstest/id6470721198?l=en-GB")!)
                        Link("Terms and Conditions", destination: URL(string: "https://sites.google.com/view/singularity-developers/einbuergerungstest")!)
                    }
                
            }
        }
    }
}


#Preview {
    SettingsView(
        isSettingViewShowing: .constant(true),
        isHistoryViewShowing: .constant(false), selectedTheme: .constant(.animatedColorTheme),
        selectedTextBackgroundTheme: .constant(.circleTextBackground),
        interval1: .constant(10),
        interval2: .constant(15),
        isVibrationOn: .constant(true),
        isAnimationOn: .constant(true), isFlashingColorsOn: .constant(true),
        selectedColor: .constant(.green)
    )
}




