//
//  HomeScreen.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-26.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var roundData: RoundData
    
    var body: some View {
        VStack {
            Text("Hello")
                .font(.title)
            Text("Max")
                .font(.title3)
            
            List(roundData.rounds) { round in
                HStack {
                    VStack(alignment: .leading) {
                        Text(round.course)
                            .font(.headline)
                        Text("Score: \(round.score)")
                            .font(.subheadline)
                        Text("Strokes: \(round.strokes)")
                            .font(.subheadline)
                        Text(round.date, style: .date)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(RoundData())
}
