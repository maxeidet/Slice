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
    let shots: [Shot]
}
struct Shot: Identifiable {
    let id = UUID()
    let holeNumber: Int
    let shotNumber: Int
    let latitude: Double
    let longitude: Double
}
struct testRound {
    let id = UUID()
    let shots: [Shot]
}

class TestRoundData: ObservableObject {
    @Published var rounds: [testRound] = [
        testRound(shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 59.3293, longitude: 18.0686), // Tee shot
            Shot(holeNumber: 1, shotNumber: 2, latitude: 59.3295, longitude: 18.0688), // Fairway
            Shot(holeNumber: 1, shotNumber: 3, latitude: 59.3297, longitude: 18.0690), // Green
            Shot(holeNumber: 2, shotNumber: 1, latitude: 59.3300, longitude: 18.0700), // Tee shot
            Shot(holeNumber: 2, shotNumber: 2, latitude: 59.3303, longitude: 18.0703), // Fairway
            Shot(holeNumber: 2, shotNumber: 3, latitude: 59.3305, longitude: 18.0705), // Green
        ]),
        testRound(shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 59.3141, longitude: 18.0711), // Tee shot
            Shot(holeNumber: 1, shotNumber: 2, latitude: 59.3143, longitude: 18.0714), // Fairway
            Shot(holeNumber: 1, shotNumber: 3, latitude: 59.3145, longitude: 18.0717), // Green
            Shot(holeNumber: 2, shotNumber: 1, latitude: 59.3150, longitude: 18.0720), // Tee shot
            Shot(holeNumber: 2, shotNumber: 2, latitude: 59.3152, longitude: 18.0723), // Fairway
            Shot(holeNumber: 2, shotNumber: 3, latitude: 59.3154, longitude: 18.0725), // Green
        ]),
    ]

    func addTestRound(_ round: testRound) {
        rounds.append(round)
    }
}



class RoundData: ObservableObject {
    @Published var rounds: [DataModel] = [
        DataModel(date: createDate(year: 2024, month: 07, day: 09), score: 13, course: "Rättviks GK", strokes: 90, image: "rgk", scores: [1: "4", 2: "5", 3: "4", 4: "5", 5: "4", 6: "3", 7: "4", 8: "5", 9: "3", 10: "5", 11: "4", 12: "5", 13: "3", 14: "4", 15: "5", 16: "3", 17: "4", 18: "5"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

         
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
        DataModel(date: createDate(year: 2024, month: 09, day: 10), score: 14, course: "Linköpings GK", strokes: 90, image: "lkgk", scores: [1: "4", 2: "5", 3: "4", 4: "4", 5: "3", 6: "5", 7: "3", 8: "4", 9: "5", 10: "4", 11: "3", 12: "5", 13: "4", 14: "5", 15: "3", 16: "5", 17: "4", 18: "4"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

    
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712),
           
            Shot(holeNumber: 3, shotNumber: 1, latitude:  58.402620741291514, longitude: 15.56008540344026)]
                 ),
        DataModel(date: createDate(year: 2024, month: 09, day: 28), score: 14, course: "Linköpings GK", strokes: 100, image: "lkgk", scores: [1: "5", 2: "4", 3: "5", 4: "4", 5: "5", 6: "6", 7: "4", 8: "5", 9: "5", 10: "6", 11: "4", 12: "5", 13: "5", 14: "4", 15: "6", 16: "5", 17: "5", 18: "6"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

         
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
        DataModel(date: createDate(year: 2024, month: 10, day: 19), score: 14, course: "Leksands GK", strokes: 110, image: "lgk", scores: [1: "6", 2: "5", 3: "6", 4: "6", 5: "5", 6: "7", 7: "6", 8: "5", 9: "6", 10: "7", 11: "6", 12: "5", 13: "6", 14: "5", 15: "6", 16: "6", 17: "5", 18: "7"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

         
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
        DataModel(date: createDate(year: 2024, month: 10, day: 25), score: 14, course: "Leksands GK", strokes: 95, image: "lgk", scores: [1: "5", 2: "4", 3: "5", 4: "4", 5: "5", 6: "6", 7: "4", 8: "5", 9: "5", 10: "6", 11: "4", 12: "5", 13: "5", 14: "4", 15: "6", 16: "5", 17: "4", 18: "5"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

         
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
        DataModel(date: createDate(year: 2024, month: 11, day: 15), score: 27, course: "Lidingö GK", strokes: 88, image: "ligk", scores: [1: "4", 2: "4", 3: "3", 4: "5", 5: "3", 6: "4", 7: "4", 8: "3", 9: "5", 10: "4", 11: "3", 12: "4", 13: "3", 14: "4", 15: "4", 16: "5", 17: "3", 18: "4"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

         
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
        DataModel(date: createDate(year: 2024, month: 11, day: 15), score: 27, course: "Lidingö GK", strokes: 88, image: "ligk", scores: [1: "4", 2: "4", 3: "3", 4: "5", 5: "3", 6: "4", 7: "4", 8: "3", 9: "5", 10: "4", 11: "3", 12: "4", 13: "3", 14: "4", 15: "4", 16: "5", 17: "3", 18: "4"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

         
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
        DataModel(date: createDate(year: 2024, month: 11, day: 15), score: 27, course: "Lidingö GK", strokes: 88, image: "ligk", scores: [1: "4", 2: "4", 3: "3", 4: "5", 5: "3", 6: "4", 7: "4", 8: "3", 9: "5", 10: "4", 11: "3", 12: "4", 13: "3", 14: "4", 15: "4", 16: "5", 17: "3", 18: "4"], shots: [
            Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
            Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
            Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),
            Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
            Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
            Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
            Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)]
                 ),
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
