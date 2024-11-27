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
            
      
        VStack {
            Text("Welcome")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            HStack(alignment:.top) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .fontWeight(.semibold)
                        .font(.title2)
                        .foregroundStyle(.white)
                    Text("HCP: \(user.hcp)")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                    Text("Rounds played: 40")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                }
                Spacer()
                
                Text("Edit profile")
                    .foregroundStyle(Color(.white))
                    .font(.subheadline)
            }
            .padding(20)
        }
 
        .frame(width: 420, height: 150)
        .background(
            Image("homeImage")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        )
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Recent Games")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    Spacer()
                    
                    Text("All")
                        .font(.subheadline)
                        .underline()
                        .foregroundStyle(Color(.black))
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                ForEach(roundData.rounds.sorted(by: { $0.date > $1.date }).indices, id: \.self) { index in
                    let round = roundData.rounds.sorted(by: { $0.date > $1.date })[index]
                    
                        RecentCard(date: formattedDate(round.date), score: round.score, club: round.course, image: round.image)
                    }
                    
                }
                .frame(height: 120)
            }
            
            
            //Contries
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
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            Image("norge")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: 40, height: 40)
                            
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
            //.background(Color(.white))
            .background(Color(.gray))
            .cornerRadius(20)
            .padding()
            
            //Stats Graph
            VStack{
                Chart(roundData.rounds) { round in
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
                .chartYScale(domain: 70...worstScore)
                .frame(height: 100)
                .padding(.horizontal, 25)
            }
            
            Spacer()
            
        }
    }
    
    // Functions
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
