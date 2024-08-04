//
//  ShareSocialMediaView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 04.08.24.
//

import SwiftUI

struct ShareSocialMediaView: View {
    @Binding var count: Int
    var historyRecord: HistoryRecord
    let onSelectRecord: (HistoryRecord) -> Void
    var body: some View {
        Button(action: {
            onSelectRecord(historyRecord)
        }){
            Text("Continue")
        }
    }
}

#Preview {
    ShareSocialMediaView(historyRecord: HistoryRecord(count: 20, date: Date(), name: "Push Ups"), onSelectRecord: { record in
        print("Selected record: \(record.name), Count: \(record.count)")
    })
}
