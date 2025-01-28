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
    @State private var shots: [Shot] = []
    @Environment(\.dismiss) var dismiss
    var course: Course
    @State private var isShowingScorecard = false
    @EnvironmentObject var roundData: RoundData
    @StateObject private var locationManager = LocationManager()
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
                        
                    }
                }) {
                    Text("Next")
                        .frame(width: 35)
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                }
            }
            .padding(.horizontal)
            
            VStack{
                
            }
            .frame(height: 20)
            
            HoleCard(
                holeNumber: course.holes[currentHole].number,
                par: course.holes[currentHole].par,
                index: course.holes[currentHole].index,
                imageName: course.holes[currentHole].imageName,
                greenLocation: course.holeLocations[course.holes[currentHole].number] ?? CLLocationCoordinate2D(latitude: 58.40344449632029, longitude: 15.579884381028368)
            )
            
            if currentHole == 9 {
                Button(action: {
                    finishRound()
                }, label: {
                    Text("Finnish")
                    
                })
            }
            Spacer()
            
            Button(action: {
                registerShot(holeNumber:currentHole + 1)
            }) {
                Text("Reg")
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
    private func registerShot(holeNumber: Int) {
        guard let coordinates = locationManager.getCurrentCoordinates() else {
            print("Could not get location")
            return
        }
        
        let shotNumber = shots.filter { $0.holeNumber == holeNumber }.count + 1
        let newShot = Shot(holeNumber: holeNumber, shotNumber: shotNumber, latitude: coordinates.latitude, longitude: coordinates.longitude)
        shots.append(newShot)
        print("Shot \(shotNumber) for hole \(holeNumber) registered at (\(coordinates.latitude), \(coordinates.longitude))")
    }
    
}

#Preview {
    GolfingScreen(course: linkopingGK)
}
