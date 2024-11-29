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
        DataModel(date: createDate(year: 2024, month: 07, day: 09), score: 19, course: "Rättviks GK", strokes: 90, image: "rgk", scores: [1: "4", 2: "5", 3: "4", 4: "5", 5: "4", 6: "3", 7: "4", 8: "5", 9: "3", 10: "5", 11: "4", 12: "5", 13: "3", 14: "4", 15: "5", 16: "3", 17: "4", 18: "5"]),
        DataModel(date: createDate(year: 2024, month: 09, day: 10), score: 19, course: "Linköpings GK", strokes: 90, image: "lkgk", scores: [1: "4", 2: "5", 3: "4", 4: "4", 5: "3", 6: "5", 7: "3", 8: "4", 9: "5", 10: "4", 11: "3", 12: "5", 13: "4", 14: "5", 15: "3", 16: "5", 17: "4", 18: "4"]),
        DataModel(date: createDate(year: 2024, month: 09, day: 28), score: 19, course: "Linköpings GK", strokes: 100, image: "lkgk", scores: [1: "5", 2: "4", 3: "5", 4: "4", 5: "5", 6: "6", 7: "4", 8: "5", 9: "5", 10: "6", 11: "4", 12: "5", 13: "5", 14: "4", 15: "6", 16: "5", 17: "5", 18: "6"]),
        DataModel(date: createDate(year: 2024, month: 10, day: 19), score: 14, course: "Leksands GK", strokes: 110, image: "lgk", scores: [1: "6", 2: "5", 3: "6", 4: "6", 5: "5", 6: "7", 7: "6", 8: "5", 9: "6", 10: "7", 11: "6", 12: "5", 13: "6", 14: "5", 15: "6", 16: "6", 17: "5", 18: "7"]),
        DataModel(date: createDate(year: 2024, month: 10, day: 25), score: 14, course: "Leksands GK", strokes: 95, image: "lgk", scores: [1: "5", 2: "4", 3: "5", 4: "4", 5: "5", 6: "6", 7: "4", 8: "5", 9: "5", 10: "6", 11: "4", 12: "5", 13: "5", 14: "4", 15: "6", 16: "5", 17: "4", 18: "5"]),
        DataModel(date: createDate(year: 2024, month: 11, day: 15), score: 17, course: "Lidingö GK", strokes: 88, image: "ligk", scores: [1: "4", 2: "4", 3: "3", 4: "5", 5: "3", 6: "4", 7: "4", 8: "3", 9: "5", 10: "4", 11: "3", 12: "4", 13: "3", 14: "4", 15: "4", 16: "5", 17: "3", 18: "4"]),
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
