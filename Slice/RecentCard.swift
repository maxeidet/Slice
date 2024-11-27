//
//  RecentCard.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI

struct RecentCard: View {
    let date: String
    let score: Int
    let club: String
    let image: String

    var body: some View {
        VStack {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                VStack {
                    Text(club)
                        .font(.subheadline)
                    Text(date)
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                .frame(width: 110)
                
                Text("\(score > 0 ? "+\(score)" : "\(score)")")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(score >= 0 ? .red : .green)
                    .frame(width: 50)
            }
            
        }
        .padding(.horizontal)
        .frame(width: 250, height: 100)
        //.frame(width: 150, height: 150)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}


#Preview {
    RecentCard(
        date: "4 September 2024",
        score: 10,
        club: "Linköpings GK",
        image: "lkgk")
}




