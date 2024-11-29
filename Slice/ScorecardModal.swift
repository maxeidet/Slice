//
//  ScorecardModal.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI

struct ScorecardModal: View {
    @Environment(\.dismiss) var dismiss
    @State private var scoreInput: String = ""
    @Binding var scores: [Int: String]
    let currentH: Int
    var course: Course
    
    var body: some View {
        VStack(spacing: 16) {
            header
            scorecard
            Divider()
            scoreInputSection
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    private var header: some View {
        HStack {
            Text("Scorecard")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title3)
                    .foregroundColor(.black.opacity(0.7))
            })
        }
        .padding(.bottom, 8)
        
    }
    
    private var scorecard: some View {
        VStack(spacing: 0) {
            createHeaderRow(label: "Hole", values: course.holes.map { "\($0.number)" }, backgroundColor: .greenApp, foregroundColor: .white)
                .clipShape(
                    RoundedCornerShape(corners: [.topLeft, .topRight], radius: 10)
                )
            createHeaderRow(label: "Hcp", values: course.holes.map { "\($0.index)" }, backgroundColor: .white, foregroundColor: .black)
            createHeaderRow(label: "Par", values: course.holes.map { "\($0.par)" }, backgroundColor: .lightGrayApp, foregroundColor: .black)
            createScoreRow(label: "Strokes", values: course.holes.indices.map { scores[$0] ?? "-" }, backgroundColor: .white, foregroundColor: .black)
            createScoreRow(label: "Points", values: course.holes.map { _ in "-" }, backgroundColor: .lightGrayApp, foregroundColor: .black)
            
            //last 18
            createHeaderRow(label: "Hole", values: course.holes.map { "\($0.number)" }, backgroundColor: .greenApp, foregroundColor: .white)
            createHeaderRow(label: "Hcp", values: course.holes.map { "\($0.index)" }, backgroundColor: .white, foregroundColor: .black)
            createHeaderRow(label: "Par", values: course.holes.map { "\($0.par)" }, backgroundColor: .lightGrayApp, foregroundColor: .black)
            createScoreRow(label: "Strokes", values: course.holes.indices.map { scores[$0] ?? "-" }, backgroundColor: .white, foregroundColor: .black)
            createScoreRow(label: "Points", values: course.holes.map { _ in "-" }, backgroundColor: .lightGrayApp, foregroundColor: .black)
            
            HStack {
                Text("Strokes:\(totalStrokes ())")
                Spacer()
                Text("Points: 0")
            }
            .font(.headline)
            .padding(.top, 8)
        }
    }
    
    private var scoreInputSection: some View {
        VStack(spacing: 0) {
            Text("Enter Your Score")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Hole: \(currentH + 1)") // Adjusted to show 1-based index
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                TextField("Score", text: $scoreInput)
                    .padding()
                    .frame(width: 80, height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 3)
                
                Button(action: {
                    if let score = Int(scoreInput) {
                        scores[currentH + 1] = "\(score)"
                        scoreInput = ""
                    }
                }) {
                    Text("Ok")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .foregroundColor(.white)
                        .background(Color.greenApp)
                        .cornerRadius(8)
                }
                .frame(width: 80)
            }
            .padding()
        }
        .padding(.horizontal)
    }
    
    func createHeaderRow(label: String, values: [String], backgroundColor: Color, foregroundColor: Color) -> some View {
        HStack(spacing: 0) {
            Text(label)
                .frame(width: 70)
                .font(.subheadline)
                .fontWeight(.bold)
            Divider()
                .frame(height: 20)
                .background(foregroundColor)
            ForEach(values, id: \.self) { value in
                Text(value)
                    .frame(width: 30)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Divider()
                    .frame(height: 20)
                    .background(foregroundColor)
            }
        }
        .padding(.horizontal)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
    }
    
    func createScoreRow(label: String, values: [String], backgroundColor: Color, foregroundColor: Color) -> some View {
        HStack(spacing: 0) {
            Text(label)
                .frame(width: 70)
                .font(.subheadline)
                .fontWeight(.bold)
            Divider()
                .frame(height: 20)
                .background(foregroundColor)
            ForEach(values.indices, id: \.self) { index in
                Text(scores[index + 1] ?? "-")
                    .frame(width: 30)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Divider()
                    .frame(height: 20)
                    .background(foregroundColor)
            }
        }
        .padding(.horizontal)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
    }
    
    
    struct RoundedCornerShape: Shape {
        var corners: UIRectCorner
        var radius: CGFloat
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            return Path(path.cgPath)
        }
    }
    
    func totalStrokes () -> Int {
        return scores.values.compactMap { Int($0) }.reduce(0, +)
    }
    // Function to calculate points based on score and hole's par, adjusted for handicap
    func calculateHandicapBasedPoints(score: Int, holePar: Int, holeIndex: Int, handicap: Int) -> Int {
        // Calculate the total extra strokes this player gets
        let extraStrokes = handicap / 18  // One extra stroke per 18 holes, evenly distributed
        
        // Determine if the player gets an extra stroke on this hole based on their handicap
        let extraStroke = holeIndex <= handicap % 18 + extraStrokes ? 1 : 0
        
        // Apply extra stroke if applicable
        let adjustedScore = score - extraStroke
        
        // Stableford Scoring System adjusted for handicap
        switch adjustedScore - holePar {
        case _ where adjustedScore < holePar - 2:
            return 4 // Eagle (2 strokes under par)
        case _ where adjustedScore == holePar - 1:
            return 3 // Birdie (1 stroke under par)
        case _ where adjustedScore == holePar:
            return 2 // Par (no strokes over par)
        case _ where adjustedScore == holePar + 1:
            return 1 // Bogey (1 stroke over par)
        case _ where adjustedScore == holePar + 2:
            return 0 // Double Bogey (2 strokes over par)
        default:
            return 0 // Triple Bogey or worse
        }
    }
}

#Preview {
    @State var scores: [Int: String] = [:]
    return ScorecardModal(scores: $scores, currentH: 0, course: linkopingGK)
}
