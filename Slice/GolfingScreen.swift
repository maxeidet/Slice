//
//  GolfingScreen.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI
import CoreLocation
import ActivityKit

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
    @State private var navigateToHome = false
    @State private var isShowingExit = false
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    isShowingExit = true
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(Color(.red))
                })
                .frame(width: 35)
                .alert("Exit Game?", isPresented: $isShowingExit) {
                    Button("Cancel", role: .cancel) { }
                    Button("Exit", role: .destructive) {
                        endDistanceActivity()
                        navigateToHome = true
                    }
                } message: {
                    Text("Are you sure you want to exit? Your progress will NOT be saved.")
                }
                NavigationLink(destination: HomeScreen(), isActive: $navigateToHome) {
                                EmptyView()
                            }
                Spacer()
                Text(course.name)
                Spacer()
                Button(action: {
                    if currentHole < course.holes.count - 1 {
                        currentHole += 1
                        locationManager.startUpdatingLocation(to: course.holeLocations[course.holes[currentHole].number]!)
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
            .padding(.top)
            Image(course.image)
                .resizable()
                .frame(width: 50, height: 50)
            
            
            HoleCard(
                holeNumber: course.holes[currentHole].number,
                par: course.holes[currentHole].par,
                index: course.holes[currentHole].index,
                imageName: course.holes[currentHole].imageName,
                greenLocation: course.holeLocations[course.holes[currentHole].number] ?? CLLocationCoordinate2D(latitude: 58.40344449632029, longitude: 15.579884381028368),
                locationManager: locationManager
               
            )
        
            if currentHole == 8 {
                Button(action: {
                    finishRound()
                }, label: {
                    Text("Finnish")
                        .foregroundStyle(.blue)
                    
                })
            }
            Spacer()
            
            HStack {
                // Open Scorecard Modal Button
                Button(action: {
                    isShowingScorecard.toggle()
                }) {
                    VStack {
                        Image(systemName: "menucard")
                            .font(.title3)
                        Text("Scorecard")
                            .font(.caption)
                        
                    }
                    .frame(width: 100, height: 50)
                    //.background(Color.greenApp)
                    .foregroundColor(.black)
                    //.cornerRadius(10)
                    
                }
                .shadow(color: .black.opacity(0.2), radius: 3)
                Spacer()
                
                Button(action: {
                    registerShot(holeNumber: currentHole + 1)
                }) {
                    
                    VStack {
                        Image(systemName: "figure.golf")
                            .font(.title3)
                        Text("Register shot")
                            .font(.caption)
                        
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(Color.black)
                
                    
                }
                .shadow(color: .black.opacity(0.2), radius: 3)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .sheet(isPresented: $isShowingScorecard) {
            ScorecardModal(scores: $scores, currentH: currentHole, course: course)
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: locationManager.distance) { newDistance in
            if let distance = newDistance {
                startDistanceActivity(distance: Int(distance))
            }
        }

        
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
                scores: scores,
                shots: shots
            )
            endDistanceActivity()
            roundData.addRound(newRound)
        }
    private func registerShot(holeNumber: Int) {
        guard let coordinates = locationManager.getCurrentCoordinates()
        else {
            print("Could not get location")
            return
        }
        
        let shotNumber = shots.filter { $0.holeNumber == holeNumber }.count + 1
        let newShot = Shot(holeNumber: holeNumber, shotNumber: shotNumber, latitude: coordinates.latitude, longitude: coordinates.longitude)
        shots.append(newShot)
        print("Shot \(shotNumber) for hole \(holeNumber) registered at (\(coordinates.latitude), \(coordinates.longitude))")
    }
    private func startDistanceActivity(distance: Int) {
        let attributes = DistanceActivityAttributes(name: course.name)
        
        let newContentState = DistanceActivityAttributes.ContentState(
            distance: distance,
            holeNumber: course.holes[currentHole].number,
            par: course.holes[currentHole].par,
            index: course.holes[currentHole].index
           
        )

        // Check if there is an existing Live Activity
        if let existingActivity = Activity<DistanceActivityAttributes>.activities.first {
            // Update the existing Live Activity
            Task {
                do {
                    try await existingActivity.update(using: newContentState)
                    print("Updated Live Activity with distance: \(distance) m")
                } catch {
                    print("Failed to update Live Activity: \(error)")
                }
            }
        } else {
            // Start a new Live Activity if none exists
            do {
               let distanceActivity = try Activity<DistanceActivityAttributes>.request(
                    attributes: attributes,
                    contentState: newContentState,
                    pushType: nil
                )
                print("Started Live Activity: \(distanceActivity.id)")
            } catch {
                print("Failed to start Live Activity: \(error)")
            }
        }
    }
    
    func endDistanceActivity() {
        for activity in Activity<DistanceActivityAttributes>.activities {
            Task {
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
    
}

#Preview {
    GolfingScreen(course: linkopingGK)
}
