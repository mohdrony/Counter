//
//  IntervalSelectionButton.swift
//  Counter
//
//  Created by Mohd Robiul Alam on 25.07.24.
//

import SwiftUI

struct IntervalSelectionButton: View {
    @Binding var interval1: Int
        @Binding var interval2: Int
        @State private var tempInterval1: String = ""
        @State private var tempInterval2: String = ""

    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("First Multiplier").font(.caption)
                HStack{
                    
                    TextField("\(interval1)", text: $tempInterval1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: tempInterval1){ newValue in
                            interval1 = Int(newValue) ?? 0
                        }
                    Text("x").bold()
                }
            }.padding(.horizontal, 10).padding(.vertical, 5).background(Color.gray.opacity(0.2)).cornerRadius(5)
            VStack(alignment: .leading){
                
                Text("Second Multiplier").font(.caption)
                HStack{
                    TextField("\(interval2)", text: $tempInterval2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: tempInterval2){ newValue in
                            interval2 = Int(newValue) ?? 0
                        }
                    Text("x").bold()
                }
            }.padding(.horizontal, 10).padding(.vertical, 5).background(Color.gray.opacity(0.2)).cornerRadius(5)
        }.keyboardType(.numberPad)
    }
}

#Preview {
    IntervalSelectionButton(interval1: .constant(10), interval2: .constant(100))
}
