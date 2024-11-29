//
//  GolfingScreen.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI
import CoreLocation

struct GolfingScreen: View {
    @State private var currentHole = 0
    @State private var scores: [Int: String] = [:]
    @State private var strokes = 0
    @Environment(\.dismiss) var dismiss
    var course: Course
    @State private var isShowingScorecard = false
    @EnvironmentObject var roundData: RoundData
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color(.black))
                })
                .frame(width: 35)
                
                Spacer()
                Text(course.name)
                Spacer()
                Button(action: {
                    if currentHole < course.holes.count - 1 {
                        currentHole += 1
                    } else {
                        //currentHole = 0
                    }
                }) {
                    Text("Next")
                        .frame(width: 35)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                }
            }
            .padding()
            
            
            
            HoleCard(
                holeNumber: course.holes[currentHole].number,
                par: course.holes[currentHole].par,
                index: course.holes[currentHole].index,
                imageName: course.holes[currentHole].imageName,
                greenLocation: course.holeLocations[course.holes[currentHole].number] ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
            )
            
         
            if currentHole == 8 {
                Button(action: {
                    finishRound()
                }, label: {
                    Text("Finnish")
                    
                })
            }
            
            // Open Scorecard Modal Button
            Button(action: {
                isShowingScorecard.toggle()
            }) {
                Text("Scorecard")
                    .padding()
                    .background(Color.greenApp)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 3)
            
            Spacer()
        }
        .sheet(isPresented: $isShowingScorecard) {
            ScorecardModal(scores: $scores, currentH: currentHole, course: course)
        }
        .navigationBarBackButtonHidden(true)

        
    }
    
    private func totalStrokes() -> Int {
        return scores.values.compactMap { Int($0) }.reduce(0, +)
    }
    private func finishRound() {
            let newRound = DataModel(
                date: Date(),
                score: 36,
                course: course.name,
                strokes: totalStrokes(),
                image: course.image,
                scores: scores
            )
            roundData.addRound(newRound)
        }
    
}

#Preview {
    GolfingScreen(course: linkopingGK)
}
