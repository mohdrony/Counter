//
//  HistoryRecord.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 01.08.24.
//

import SwiftUI

struct HistoryRecord: Identifiable, Codable {
    let id = UUID()
    var count: Int
    var date: Date
    var name: String
}

