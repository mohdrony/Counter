//
//  HistoryView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 01.08.24.
//

import SwiftUI

struct HistoryView: View {
    @Binding var historyRecords: [HistoryRecord]
//    let onSelectRecord: (HistoryRecord) -> Void

    @State private var editMode = EditMode.inactive

    var body: some View {
        NavigationView {
            List {
                ForEach(historyRecords.indices, id: \.self) { index in
                    
                    NavigationLink{ShareSocialMediaView(historyRecord: historyRecords[index]){ selectedRecord in
                        count = selectedRecord.count
                        isHistoryViewShowing = false
                    }} label:{
                        HStack{
                            VStack(alignment: .leading) {
                                TextField("Name", text: $historyRecords[index].name)
                                    .font(.subheadline).bold()
                                    .disabled(editMode == .inactive)
                                Text("Date: \(historyRecords[index].date.formatted())")
                                    .font(.subheadline)
                            }.foregroundColor(editMode == .active ? .blue : .black)
                            
                            ZStack{
                                Circle().fill(.white).frame(width: 50)
                                Text("\(historyRecords[index].count)")
                                    .font(.custom("Karantina", size: 40)).minimumScaleFactor(0.2).lineLimit(1).frame(maxWidth: 45)
                            }
                        }
                    }
                    
                }
                .onDelete { indices in
                    historyRecords.remove(atOffsets: indices)
                    saveHistory()
                }
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Clear") {
                        historyRecords.removeAll()
                        UserDefaults.standard.removeObject(forKey: "historyRecords")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
    }

    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(historyRecords) {
            UserDefaults.standard.set(encoded, forKey: "historyRecords")
        }
    }
}

// Custom date formatter for displaying the date in HistoryView
extension Date {
    func formatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

#Preview {
    HistoryView(
        historyRecords: .constant([
            HistoryRecord(count: 30, date: Date(), name: "Record 1"),
            HistoryRecord(count: 50, date: Date().addingTimeInterval(-86400), name: "Record 2")
        ]),
        onSelectRecord: { record in
            print("Selected record: \(record.name), Count: \(record.count)")
        }
    )
}
