//
//  SliceApp.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-26.
//

import SwiftUI

@main
struct SliceApp: App {
    @StateObject private var roundData = RoundData()
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(roundData)
        }
    }
}
