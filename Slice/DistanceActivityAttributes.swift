//
//  DistanceActivityAttributes.swift
//  Slice
//
//  Created by Max Eidet on 2025-01-30.
//

import Foundation
import ActivityKit

struct DistanceActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var distance: Int
        var holeNumber: Int
        var par: Int
        var index: Int
    }

    var name: String
}
