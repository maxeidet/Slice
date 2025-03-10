//
//  HomeScreen.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-26.
//

import SwiftUI
import Charts

struct HomeScreen: View {
    @EnvironmentObject var roundData: RoundData
    @StateObject var viewModel = UserViewModel ()
    private var user: User {
        return viewModel.user
    }
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading, spacing: 8) {
                // TOP HStack
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)

                        Text(user.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.greenApp)
                    }
                    
                    Spacer()
                    
                    VStack (spacing: 8){
                        Image("\(user.image)")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60)
                            .clipShape(Circle())
                        NavigationLink(destination: ProfileView()) {
                            Text("Edit profile")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                }
                
                // Secound HStack
                HStack(spacing: 15) {
                    VStack {
                        Text("HCP")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(user.hcp)")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    
                    Divider()
                        .frame(height: 30)
                    
                    VStack {
                        Text("AVG")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(averageScore))")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    
                    Divider()
                        .frame(height: 30)
                    VStack {
                        Text("Best")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("71")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    Divider()
                        .frame(height: 30)
                    VStack {
                        Text("Rounds")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("40")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                   
                    Spacer()
                    
                    
                    // Come up with something the view here
                }
                //.padding(.top, 4)
            }
            .frame(width: 370, height: 150)
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Recent Games")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    NavigationLink( destination: AllRounds()){
                        Text("All")
                            .font(.subheadline)
                            .underline()
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(roundData.rounds.sorted(by: { $0.date > $1.date }).indices, id: \.self) { index in
                        let round = roundData.rounds.sorted(by: { $0.date > $1.date })[index]
                        NavigationLink(destination: GameDetailView(round: round)) {
                            RecentCard(date: formattedDate(round.date), score: round.score, club: round.course, image: round.image)
                        }
                        .foregroundColor(.black)
                      
                    }
                    
                }
                .padding(.horizontal)
                .frame(height: 120)
            }
            
            
            // Countries
            VStack {
                HStack {
                    VStack {
                        Text("3")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Courses Played")
                            .font(.subheadline)
                        HStack {
                            Image("sverige")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 30, height: 30)
                            Image("norge")
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 30, height: 30)
                        }
                    }
                    Spacer()
                    Image("world")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                }
                .padding(.horizontal)
            }
            .frame(height: 150)
            .background(Color(.beige))
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.2), radius: 3)
            .padding()
            
            //Stats & Graph
            HStack {
                Text("Statistics")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack {
                Chart(roundData.rounds.sorted(by: { $0.date < $1.date })) { round in
                    LineMark(
                        x: .value("Date", round.date),
                        y: .value("Total Strokes", round.strokes)
                    )
                    .foregroundStyle(.blue)
                    .symbol(Circle())
                    .symbolSize(50)
                    .interpolationMethod(.catmullRom)
                    
                    PointMark(
                        x: .value("Date", round.date),
                        y: .value("Total Strokes", round.strokes)
                    )
                    .foregroundStyle(.blue)
                    .symbol(Circle())
                    .symbolSize(50)
                    
                    RuleMark(y: .value("Average Score", averageScore))
                        .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundStyle(.red)
                        .annotation(position: .top, alignment: .leading) {
                        }
                    
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel(format: .dateTime.month(.abbreviated).year())
                    }
                }
                .chartYAxis {
                    AxisMarks(values:.automatic) { value in
                        AxisGridLine()
                        AxisTick()
                        AxisValueLabel()
                    }
                }
                .chartYScale(domain: 70...110)
                .frame(height: 100)
                .padding(25)
            }
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.05), radius: 10)
            .padding(.horizontal)
            
            /*
            NavigationLink( destination: PickCourse()){
                Text("Golf")
                    .foregroundStyle(Color(.white))
            }
            .frame(width: 100, height: 50)
            .background(Color(.greenApp))
            .cornerRadius(10)
            .padding(.vertical)
            */
            NavigationLink( destination: PickCourse()){
                Text("Play")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 150)
                    .background(.greenApp)
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .shadow(radius: 8)
            .padding(.vertical)
            Spacer()

        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    private var averageScore: Double {
        let totalScores = roundData.rounds.reduce(0) { $0 + $1.strokes }
        return roundData.rounds.isEmpty ? 0 : Double(totalScores) / Double(roundData.rounds.count)
    }
    private var bestScore: Int {
        return roundData.rounds.map { $0.strokes }.min() ?? 0
    }
    private var worstScore: Int {
        return roundData.rounds.map { $0.strokes }.max() ?? 0
    }
}

#Preview {
    HomeScreen()
        .environmentObject(RoundData())
}
