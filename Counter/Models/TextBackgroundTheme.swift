//
//  TextBackgroundTheme.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 28.07.24.
//

import SwiftUI

enum TextBackgroundTheme: String, Identifiable, CaseIterable, Codable {
    case circleTextBackground
    case roundedRectangleTheme
    case polygonTheme

    var id: String { self.rawValue }

    var textBackgroundThemeName: String {
        switch self {
        case .circleTextBackground:
            return "Circle"
        case .roundedRectangleTheme:
            return "Rounded Rectangle"
        case .polygonTheme:
            return "Polygon"
        }
    }

    static var textBackgroundThemes: [TextBackgroundTheme] {
        return TextBackgroundTheme.allCases
    }
}
