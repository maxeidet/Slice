//
//  GameDetailView.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI

struct GameDetailView: View {
    let round: DataModel
    @Environment (\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        withAnimation(.snappy){
                            dismiss()
                        }
                        
                    }label: {
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
                VStack {
                    Image(round.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
        
                    Text(round.course)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("\(formattedDate)")
                        .font(.caption)
                    
                    VStack() {
                        Text("Strokes: \(round.strokes)")
                            
                           
                        Text("\(round.score > 0 ? "+\(round.score)" : "\(round.score)")")
                            .foregroundStyle(Color(.red))
                        
                    }
                    .font(.title3)
                    
                }
               
                HStack {
                    Text("Results")
                        .font(.headline)
                        .fontWeight(.bold)
                        
                    Spacer()
                }
                Divider()
                ScrollView(showsIndicators: false) {
                    ForEach(round.scores.sorted(by: { $0.key < $1.key }), id: \.key) { hole, score in
                        HStack {
                            Text("Hole \(hole)")
                            Spacer()
                            Text("Par: 4")
                            Spacer()
                            Text("Strokes: \(score)")
                        }
                        .padding(.horizontal)
                        .frame(height: 20)
                        Divider()
                    }
                }
            
                
                
               
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    private var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium // You can use .short, .medium, .long, or .full
            formatter.timeStyle = .none  // No time displayed
            return formatter.string(from: round.date)
        }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleRound = DataModel(date: Date(), score: 10, course: "Leksands GK", strokes: 90, image: "leksandgk", scores: [1: "4", 2: "5", 3: "3"])
        
        return GameDetailView(round: sampleRound)
    }
}
