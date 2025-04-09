// ResultScoreCard.swift
// Slice
// Created by Max Eidet on 2024-12-09.

import SwiftUI

struct ResultScoreCard: View {
    let scores: [Int: String]
    let parValues = [4, 5, 3, 4, 4, 3, 5, 4, 4, 4, 3, 5, 4, 4, 3, 4, 5, 4] // Realistic 18-hole par
    
    var body: some View {
        
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                holeRow(holes: 1...9)
                parRow(holes: 0..<9)
                scoreRow(holes: 1...9)
            }
            
            VStack(spacing: 0) {
                holeRow(holes: 10...18)
                parRow(holes: 9..<18)
                scoreRow(holes: 10...18)
            }
            
            totalsRow
                .padding(.bottom, 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 1)
        
        
    }
    
    private func holeRow(holes: ClosedRange<Int>) -> some View {
        HStack(spacing: 0) {
            if holes.lowerBound == 1 {
                Text("Hole")
                    .frame(width: 40, alignment: .leading)
                    .foregroundStyle(.white)
            } else if holes.lowerBound == 10 { // When starting Hole 10
                Text("Hole")
                    .frame(width: 40, alignment: .leading)
                    .foregroundStyle(.white)
            } else {
                Spacer()
                    .frame(width: 40)
            }
            
            ForEach(holes, id: \.self) { hole in
                Text("\(hole)")
                    .frame(width: 25, height: 24)
                    .foregroundStyle(.white)
            }
            Text("Out")
                .frame(width: 32, height: 24)
                .foregroundStyle(.white)
            
            //Spacer() // Ensures the background fills the full width
        }
        .padding(.horizontal)
        //.frame(maxWidth: .infinity) // Forces full width
        .background(Color.greenApp) // Makes sure background fills entire row
        .font(.subheadline)
    }
    
    private func parRow(holes: Range<Int>) -> some View {
        HStack(spacing: 0) {
            if holes.lowerBound == 0 {
                Text("Par")
                    .frame(width: 40, alignment: .leading)
                    .foregroundStyle(.secondary)
            } else if holes.lowerBound == 9 { // When starting Hole 10
                Text("Par")
                    .frame(width: 40, alignment: .leading)
                    .foregroundStyle(.secondary)
            } else {
                Spacer()
                    .frame(width: 40)
            }
            
            ForEach(holes, id: \.self) { index in
                Text("\(parValues[index])")
                    .frame(width: 25, height: 24)
                    .foregroundStyle(.secondary)
            }
            Text("")
                .frame(width: 32, height: 24)
                .foregroundStyle(.white)
            
            //Spacer()
        }
        .padding(.horizontal)
        //.frame(maxWidth: .infinity)
        .font(.subheadline)
    }
    
    private func scoreRow(holes: ClosedRange<Int>) -> some View {
        HStack(spacing: 0) {
            if holes.lowerBound == 1 {
                Text("Score")
                    .frame(width: 40, alignment: .leading)
                    .foregroundStyle(.secondary)
            } else if holes.lowerBound == 10 {
                Text("Score")
                    .frame(width: 40, alignment: .leading)
                    .foregroundStyle(.secondary)
            }
            else {
                Spacer()
                    .frame(width: 40)
            }
            ForEach(holes, id: \.self) { hole in
                let score = scores[hole] ?? "0"
                Text(score)
                    .frame(width: 25, height: 24)
                    .foregroundStyle(score != "0" ? .secondary : .secondary)
                    .background(score != "0" ? Color(.white) : Color.clear)
            }
            if holes.lowerBound == 1 {
                Text("\(scores.filter { $0.key <= 9 }.values.compactMap { Int($0) }.reduce(0, +))")
                    .frame(width: 32, height: 24)
                    .foregroundStyle(.black)
            }
            if holes.lowerBound == 10 {
                Text("\(scores.filter { $0.key > 9 }.values.compactMap { Int($0) }.reduce(0, +))")
                    .frame(width: 32, height: 24)
                    .foregroundStyle(.black)
            }
            
            //Spacer()
            
        }
        .padding(.horizontal)
       // .frame(maxWidth: .infinity)
        .font(.subheadline)
    }
    
    private var totalsRow: some View {
        HStack(spacing: 0) {
            Text("Total: \(scores.values.compactMap { Int($0) }.reduce(0, +))")
                .fontWeight(.semibold)
        }
        .font(.subheadline)
        .foregroundStyle(.primary)
    }
}

#Preview {
    ResultScoreCard(scores: [
        1: "4", 2: "6", 3: "3", 4: "5", 5: "4", 6: "3", 7: "6", 8: "4", 9: "5",
        10: "4", 11: "7", 12: "6", 13: "5", 14: "4", 15: "3", 16: "4", 17: "6", 18: "5"
    ])
}
