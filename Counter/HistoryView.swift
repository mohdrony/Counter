//
//  HistoryView.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 01.08.24.
//

import SwiftUI

struct HistoryView: View {
    @Binding var historyRecords: [HistoryRecord]
    @Binding var count: Int
    @Environment(\.dismiss) private var dismiss
    @State private var editMode = EditMode.inactive

    var body: some View {
        NavigationStack {
            List {
                ForEach(historyRecords) { record in
                    NavigationLink(value: record) {
                        HStack {
                            VStack(alignment: .leading) {
                                TextField("Name", text: $historyRecords[historyRecords.firstIndex(where: { $0.id == record.id })!].name)
                                    .font(.subheadline).bold()
                                    .disabled(editMode == .inactive)
                                Text("Date: \(record.date.formatted())")
                                    .font(.subheadline)
                            }
                            .foregroundColor(editMode == .active ? .blue : .black)
                            
                            ZStack {
                                Circle().fill(.white).frame(width: 50)
                                Text("\(record.count)")
                                    .font(.custom("Karantina", size: 40))
                                    .minimumScaleFactor(0.2)
                                    .lineLimit(1)
                                    .frame(maxWidth: 45)
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
            .navigationDestination(for: HistoryRecord.self) { record in
                ShareSocialMediaView(
                    count: $count,
                    historyRecord: record,
                    onDismiss: { dismiss() } // Convert DismissAction to () -> Void
                )
            }
        }
    }

    private func saveHistory() {
        if let encoded = try? JSONEncoder().encode(historyRecords) {
            UserDefaults.standard.set(encoded, forKey: "historyRecords")
        }
    }
}

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
        ]), count: .constant(20)
        
    )
}
