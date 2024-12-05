//
//  AllRounds.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI

struct AllRounds: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchQuery: String = ""
    @EnvironmentObject var roundData: RoundData
    @State private var isSortedByBestScore = false

    var body: some View {
        VStack {
            // Navigation back button
            HStack {
                Button(action: {
                    isSortedByBestScore = false
                    sortRounds()
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(Color(.black))
                        .frame(width: 30, height: 30)
                        .background(.lightGrayApp)
                        .clipShape(Circle())
                })
                Spacer()
            }
            .padding(.horizontal)
            
            VStack {
                Text("Max's rounds")
                    .font(.title)
            }
            // Search bar
            HStack {
                TextField("Search for a course", text: $searchQuery)
                    .padding()
                if !searchQuery.isEmpty {
                    Image(systemName: "xmark")
                        .padding()
                        .onTapGesture {
                            searchQuery = ""
                        }
                }
            }
            .frame(width: 250, height: 40)
            .background(
                Rectangle()
                    .fill(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 3)
                    .opacity(0.4)
            )
            .padding(.bottom)

            // Sorting buttons
            HStack {
                Button(action: {
                    isSortedByBestScore = true
                    sortRounds()
                }) {
                    Text("Best")
                        .underline(isSortedByBestScore)
                        .foregroundStyle(Color(.black))
                        .font(.subheadline)
                }
                Button(action: {
                    isSortedByBestScore = false
                    sortRounds()
                }) {
                    Text("Recent")
                        .underline(!isSortedByBestScore)
                        .foregroundStyle(Color(.black))
                        .font(.subheadline)
                }
            }
            Divider()

            // List of rounds
            ScrollView {
                ForEach(filteredRounds) { round in
                    VStack {
                        
                        HStack{
                            VStack{
                                Image(round.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            .frame(width: 50)
                            Spacer()
                            VStack{
                                HStack {
                                    Text("\(round.course)")
                                    
                                }
                                Text("\(formattedDate(round.date))")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: 130)
                            
                            Spacer()
                            VStack{
                                Text("\(round.strokes)")
                                VStack{
                                    Text("+ \(round.score)")
                                        .font(.subheadline)
                                        .foregroundStyle(Color(.white))
                                }
                                .padding(.horizontal, 10)
                                .background(Color(.greenApp))
                                .cornerRadius(10)
                            }
                            .frame(width: 50, height: 60)
                            
                            
                            VStack{
                                
                                NavigationLink(destination: GameDetailView(round: round)) {
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(Color(.greenApp))
                                }
                                
                            }
                            
                        }
                        .frame(height: 70)
                        
                        Divider()
                        
                    }
                    .frame(width: 350)
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            sortRounds()
        }
    }

    private var filteredRounds: [DataModel] {
        if searchQuery.isEmpty {
            return roundData.rounds
        } else {
            return roundData.rounds.filter { $0.course.localizedCaseInsensitiveContains(searchQuery) }
        }
    }

    private func sortRounds() {
        if isSortedByBestScore {
            roundData.rounds.sort { $0.strokes < $1.strokes }
        } else {
            roundData.rounds.sort { $0.date > $1.date }
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct AllRounds_Previews: PreviewProvider {
    static var previews: some View {
        let roundData = RoundData()
        roundData.rounds = [
            DataModel(date: createDate(year: 2024, month: 9, day: 10), score: 19, course: "Linköpings GK", strokes: 90, image: "lkgk",
                      scores: [1: "4", 2: "5", 3: "3"]),
            DataModel(date: createDate(year: 2024, month: 10, day: 5), score: 14, course: "Leksands GK", strokes: 85, image: "lgk",
                      scores: [1: "4", 2: "5", 3: "3"]),
            DataModel(date: Date(), score: 17, course: "Lidingö Gk", strokes: 88, image: "ligk",
                      scores: [1: "4", 2: "5", 3: "3"])
        ]

        return AllRounds()
            .environmentObject(roundData)
    }
}
