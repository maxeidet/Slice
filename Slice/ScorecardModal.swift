//
//  ScorecardModal.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//
import SwiftUI

struct ScorecardModal: View {
    @Environment(\.dismiss) var dismiss
    @State private var scoreInput: String = ""
    let currentH: Int
    var course: Course
    let holes = [
        (number: 1, par: 4, index: 10, imageName: "hole1"),
        (number: 2, par: 4, index: 5, imageName: "hole2"),
        (number: 3, par: 3, index: 18, imageName: "hole3"),
        (number: 4, par: 5, index: 17, imageName: "hole4"),
        (number: 5, par: 3, index: 3, imageName: "hole5"),
        (number: 6, par: 4, index: 12, imageName: "hole6"),
        (number: 7, par: 4, index: 7, imageName: "hole7"),
        (number: 8, par: 5, index: 15, imageName: "hole8"),
        (number: 9, par: 3, index: 8, imageName: "hole9")
    ]
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    dismiss() // Close the modal
                }) {
                    Image(systemName: "xmark.circle")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            .padding()

            Text("Scorecard")
                .font(.largeTitle)
                .bold()
            VStack(alignment: .leading, spacing: 0) {

                createHeaderRow(label: "Hole", values: course.holes.map { "\($0.number)" }, backgroundColor: .greenApp, foregroundColor: .white)
                createHeaderRow(label: "Hcp", values: course.holes.map { "\($0.index)" }, backgroundColor: .white, foregroundColor: .black)
                createHeaderRow(label: "Par", values: course.holes.map { "\($0.par)" }, backgroundColor: .gray, foregroundColor: .black)
                createScoreRow(label: "Strokes", values: course.holes.map { _ in "-" }, backgroundColor: .white, foregroundColor: .black)
                createScoreRow(label: "Points", values: course.holes.map { _ in "-" }, backgroundColor: .gray, foregroundColor: .black)
                
                HStack {
                    Text("Strokes: 0")
                    Text("Points: 0")
                }
                .fontWeight(.bold)
            }
            VStack {
                Text("Enter your score")
                HStack{
                    HStack {
                        TextField("Score", text: $scoreInput)
                            .padding()
                    }
                    .frame(width: 100, height: 40)
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 3)
                            .opacity(0.4)
                    )
                    
                    Button(action: {
                        
                    }, label: {
                        Text("Ok")
                            .foregroundStyle(.white)
                    })
                    .frame(width: 50, height: 40)
                    .background(.greenApp)
                    .cornerRadius(10)
                }
                
            }
            .padding()
            
           
            Spacer()
        }
        .padding()
    }
    func createHeaderRow(label: String, values: [String], backgroundColor: Color, foregroundColor: Color) -> some View {
        HStack(spacing: 0) {
            Text(label)
                .frame(width: 70)
            Divider()
                .frame(height: 20)
                .foregroundColor(.blue)
            ForEach(values, id: \.self) { value in
                Text(value)
                    .frame(width: 30)
                Divider()
                    .frame(height: 20)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
    }
    
    func createScoreRow(label: String, values: [String], backgroundColor: Color, foregroundColor: Color) -> some View {
        HStack(spacing: 0) {
            Text(label)
                .frame(width: 70)
            Divider()
                .frame(height: 20)
                .foregroundColor(.blue)
            ForEach(values, id: \.self) { value in
                Text(value)
                    .frame(width: 30)
                Divider()
                    .frame(height: 20)
                    .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
    }
}
#Preview {
    ScorecardModal( currentH: 1, course: linkopingGK)
}
