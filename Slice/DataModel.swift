//
//  DataModel.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-26.
//

import Foundation
import SwiftUI

struct DataModel: Identifiable {
    let id = UUID()
    let date: Date
    let score: Int
    let course: String
    let strokes: Int
    let image: String
    let scores: [Int:String]
}

class RoundData: ObservableObject {
    @Published var rounds: [DataModel] = [
            DataModel(date: createDate(year: 2024, month: 9, day: 10), score: 19, course: "Linköpings GK", strokes: 90, image: "lkgk", scores: [1: "4", 2: "5", 3: "3"]),
            DataModel(date: createDate(year: 2024, month: 9, day: 28), score: 19, course: "Linköpings GK", strokes: 100, image: "lkgk", scores: [1: "4", 2: "5", 3: "3"]),
            DataModel(date: createDate(year: 2024, month: 10, day: 19), score: 14, course: "Leksands GK", strokes: 110, image: "lgk", scores: [1: "4", 2: "5", 3: "3"]),
            DataModel(date: createDate(year: 2024, month: 10, day: 25), score: 14, course: "Leksands GK", strokes: 95, image: "lgk", scores: [1: "4", 2: "5", 3: "3"]),
            DataModel(date: createDate(year: 2024, month: 11, day: 15), score: 17, course: "Lidingö GK", strokes: 88, image: "ligk", scores: [1: "4", 2: "5", 3: "3"])
        ]
    
    func addRound(_ round: DataModel) {
        rounds.append(round)
    }
}
func createDate(year: Int, month: Int, day: Int) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components) ?? Date()
}
