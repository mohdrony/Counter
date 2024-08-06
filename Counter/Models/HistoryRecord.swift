//
//  HistoryRecord.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 01.08.24.
//

import SwiftUI

import Foundation

struct HistoryRecord: Identifiable, Codable, Hashable {
    var id = UUID() // Ensure each record has a unique identifier
    var count: Int
    var date: Date
    var name: String

    // Automatic synthesis of Hashable
}


