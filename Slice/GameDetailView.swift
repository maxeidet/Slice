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
                
                VStack {
                    NavigationLink(destination: {
                        if let course = CourseRepository.allCourses.first(where: { $0.name.trimmingCharacters(in: .whitespacesAndNewlines).localizedCaseInsensitiveCompare(round.course.trimmingCharacters(in: .whitespacesAndNewlines)) == .orderedSame }) {
                            GolfMapView(shots: round.shots, course: course)
                        } else {
                            Text("Course not found")
                        }
                        }) {
                            HStack {
                                Text("Map Overview")
                                Image(systemName: "mappin.and.ellipse")
                                    .foregroundStyle(.greenApp)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                }
                .padding(.top)
                
                VStack {
                    HStack {
                        Text("Scorecard")
                        Spacer()
                    }
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
            ], shots: [
                Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394, longitude: 15.566986),
                Shot(holeNumber: 1, shotNumber: 2, latitude: 58.401799, longitude: 15.565249),
                Shot(holeNumber: 2, shotNumber: 1, latitude: 58.401206, longitude: 15.562332),
                Shot(holeNumber: 2, shotNumber: 2, latitude: 58.401271, longitude: 15.560216)
            ]
        )
        
        return GameDetailView(round: sampleRound)
    }
}
