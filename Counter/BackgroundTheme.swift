//
//  BackgroundTheme.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 28.07.24.
//

import SwiftUI

enum BackgroundTheme: String, Identifiable, CaseIterable, Codable {
    case animatedColorTheme
    case animatedBWTheme
    case flashingColorTheme
    case flashingBWTheme
    case colorTheme
    case darkTheme
    case lightTheme
    
    var id: String { self.rawValue }
    
    var themeName: String {
        switch self {
        case .animatedColorTheme:
            return "Animated Colors"
        case .animatedBWTheme:
            return "Animated B&W"
        case .flashingColorTheme:
            return "Flashing Colors"
        case .flashingBWTheme:
            return "Flashing B&W"
        case .colorTheme:
            return "Single Color"
        case .darkTheme:
            return "Dark"
        case .lightTheme:
            return "Light"
        }
    }
    static var backgroundThemes: [BackgroundTheme] {
        return BackgroundTheme.allCases
    }
}
