//
//  ResultScoreCard.swift
//  Slice
//
//  Created by Max Eidet on 2024-12-09.
//

import SwiftUI

struct ResultScoreCard: View {
    let scores: [Int:String]
    
    var body: some View {
        VStack {
            //Hole
            HStack {
                Text("Hole")
                    .frame(width: 50)
                ForEach(scores.sorted(by: { $0.key < $1.key }).prefix(9), id: \.key) { key, value in
                    Text("\(key)") // Example par; customize per hole if needed
                        .frame(width: 20)
                        .foregroundStyle(.secondary)
                }
                Text("Out")
                    .frame(width:30, height: 20)
                
            }
           
            // Par
            HStack {
                Text("Par")
                    .frame(width: 50)
                ForEach(1...9, id: \.self) { _ in
                    Text("4")
                        .frame(width: 20)
                        .foregroundStyle(.secondary)
                }
                Text("36")
                    .frame(width:30, height: 20)
            }
            
            // Score
            HStack {
                Text("Score")
                    .frame(width: 50)
                ForEach(Array(scores.sorted(by: { $0.key < $1.key }).prefix(9)), id: \.key) { hole, score in
                    Text("\(score)")
                        .frame(width: 20)
                        .foregroundStyle(.secondary)
                }
                
                Text("54")
                    .frame(width:30, height: 20)
            }
            .frame(height: 30)
        }
        .padding()
        .frame(width: 370)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 2)
       
           
    }
}

#Preview {
    ResultScoreCard(scores: [
        1: "4",
        2: "5",
        3: "3",
        4: "4",
        5: "3",
        6: "4",
        7: "3",
        8: "5",
        9: "4"
    ])
}
