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
    @Environment(\.dismiss) var dismiss
    var course: Course
    @State private var isShowingScorecard = false
    
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
            
            Spacer()
        }
        .sheet(isPresented: $isShowingScorecard) {
            ScorecardModal(scores: $scores, currentH: currentHole, course: course)
        }
        .navigationBarBackButtonHidden(true)

        
    }
    
}

#Preview {
    GolfingScreen(course: linkopingGK)
}
