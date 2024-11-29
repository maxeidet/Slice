//
//  HcpCalculator.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-28.
//

import Foundation

// Spelarens exakta handicap * ( Slope / 113 ) + (CR - Banans Par) = Antal erhållna slag.

// Function to calculate the number of strokes per hole
func calculateStrokesPerHole(handicap: Int, slopeRating: Int, courseRating: Double, par: Int, holeIndex: [Int]) -> [Int] {
    // Calculate playing handicap
    let playingHandicap = Double(handicap) * Double(slopeRating) / 113 + (courseRating - Double(par))
    
    // Round the playing handicap to the nearest integer
    let roundedHandicap = Int(round(playingHandicap))
    
    // Create an array for the number of strokes per hole
    var strokesPerHole = [Int]()
    
    // Distribute strokes based on hole index
    for index in holeIndex {
        if index <= roundedHandicap {
            strokesPerHole.append(2)  // One extra stroke for holes with index less than or equal to the playing handicap
        } else {
            strokesPerHole.append(1)  // One stroke for all other holes
        }
    }
    
    return strokesPerHole
}
