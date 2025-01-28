//
//  GameDetailView.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI

struct GameDetailView: View {
    let round: DataModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Navigation Bar
                HStack {
                    Button(action: {
                        withAnimation(.snappy) {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
                
                // Round Details
                VStack(spacing: 5) {
                    Image(round.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                    Text(round.course)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(formattedDate)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    HStack(spacing: 15) {
                        VStack {
                            Text("Total Strokes")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(round.strokes)")
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        
                        VStack {
                            Text("Score")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(round.score > 0 ? "+\(round.score)" : "\(round.score)")")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(round.score > 0 ? .red : .green)
                        }
                    }
                }
                
                // Results Section
               /* VStack(spacing: 8) {
                    HStack {
                        Text("Results")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Divider()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(round.scores.sorted(by: { $0.key < $1.key }), id: \.key) { hole, score in
                                HStack {
                                    Text("Hole \(hole)")
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text("Par: 4")
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                    Text("Strokes: \(score)")
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal)
                                .frame(height: 30)
                                Divider()
                            }
                        }
                    }
                }*/
                VStack {
                    ResultScoreCard(scores: round.scores)
                }
                .padding()
               
                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: round.date)
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRound = DataModel(
            date: Date(),
            score: 10,
            course: "Leksands GK",
            strokes: 90,
            image: "leksandsgk",
            scores: [
                1: "4",
                2: "5",
                3: "3",
                4: "4",
                5: "3",
                6: "4",
                7: "3",
                8: "5",
                9: "4"
            ]
        )
        
        return GameDetailView(round: sampleRound)
    }
}
