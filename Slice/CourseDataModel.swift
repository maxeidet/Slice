//
//  CourseDataModel.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import Foundation
import CoreLocation

// Corses can be found by: coursenameGK

struct Holes {
    let number: Int
    let par: Int
    let index: Int
    let imageName: String
    
}

struct Course {
    let holeLocations: [Int: CLLocationCoordinate2D]
    let holes: [Holes]
    let image: String
    let name: String
    let location: CLLocationCoordinate2D
    let teePositions: [Int: CLLocationCoordinate2D]
}



// Linköpings GK
let linkopingGKHoleLocations: [Int: CLLocationCoordinate2D] = [
        1: CLLocationCoordinate2D(latitude: 58.40199977960362, longitude: 15.564873846541612),
        2: CLLocationCoordinate2D(latitude: 58.401135871275926, longitude: 15.55880709410955),
        3: CLLocationCoordinate2D(latitude: 58.402102163942686, longitude: 15.556806523728074),
        4: CLLocationCoordinate2D(latitude: 58.40233285095422, longitude: 15.563865842904692),
        5: CLLocationCoordinate2D(latitude: 58.40266334196021, longitude: 15.566856366661721),
        6: CLLocationCoordinate2D(latitude: 58.403046074472144, longitude: 15.560014004601417),
        7: CLLocationCoordinate2D(latitude: 58.40345931733258, longitude: 15.562468434898701),
        8: CLLocationCoordinate2D(latitude: 58.40418108180549, longitude: 15.56873664131122),
        9: CLLocationCoordinate2D(latitude: 58.40141915456523, longitude: 15.569503177890752),
    ]

let linkopingGKHoles = [
    Holes(number: 1, par: 4, index: 10, imageName: "ehole1"),
    Holes(number: 2, par: 4, index: 6, imageName: "hole2"),
    Holes(number: 3, par: 3, index: 16, imageName: "hole3"),
    Holes(number: 4, par: 5, index: 8, imageName: "hole4"),
    Holes(number: 5, par: 3, index: 18, imageName: "hole5"),
    Holes(number: 6, par: 5, index: 2, imageName: "hole6"),
    Holes(number: 7, par: 3, index: 14, imageName: "hole7"),
    Holes(number: 8, par: 4, index: 12, imageName: "hole8"),
    Holes(number: 9, par: 4, index: 4, imageName: "hole9"),
    
    // Back 10 - 18
    Holes(number: 10, par: 4, index: 9, imageName: "hole10"),
    Holes(number: 11, par: 5, index: 3, imageName: "hole11"),
    Holes(number: 12, par: 3, index: 17, imageName: "hole12"),
    Holes(number: 13, par: 4, index: 11, imageName: "hole13"),
    Holes(number: 14, par: 5, index: 1, imageName: "hole14"),
    Holes(number: 15, par: 3, index: 15, imageName: "hole15"),
    Holes(number: 16, par: 4, index: 7, imageName: "hole16"),
    Holes(number: 17, par: 4, index: 5, imageName: "hole17"),
    Holes(number: 18, par: 5, index: 13, imageName: "hole18")
]

let linkopingGKTeePositions: [Int: CLLocationCoordinate2D] = [
    1: CLLocationCoordinate2D(latitude: 58.401200979035984, longitude: 15.569810644007386),
    2: CLLocationCoordinate2D(latitude: 58.40208415830721, longitude: 15.56432471183862),
    3: CLLocationCoordinate2D(latitude: 58.40117445097692,  longitude: 15.557950096096771),
    4: CLLocationCoordinate2D(latitude:  58.40239606016642, longitude: 15.556298194570905),
]

let linkopingGK = Course(holeLocations: linkopingGKHoleLocations, holes: linkopingGKHoles, image: "lkgk", name: "Linköpings GK", location: CLLocationCoordinate2D(latitude: 58.40127382191677, longitude: 15.570044023848054), teePositions: linkopingGKTeePositions)


// Leksands GK
let leksandsHoleLocations: [Int: CLLocationCoordinate2D] = [
    1: CLLocationCoordinate2D(latitude: 60.732, longitude: 15.003),
    2: CLLocationCoordinate2D(latitude: 60.733, longitude: 15.004),
    3: CLLocationCoordinate2D(latitude: 60.734, longitude: 15.005),
    4: CLLocationCoordinate2D(latitude: 60.735, longitude: 15.006),
    5: CLLocationCoordinate2D(latitude: 60.736, longitude: 15.007),
    6: CLLocationCoordinate2D(latitude: 60.737, longitude: 15.008),
    7: CLLocationCoordinate2D(latitude: 60.738, longitude: 15.009),
    8: CLLocationCoordinate2D(latitude: 60.739, longitude: 15.010),
    9: CLLocationCoordinate2D(latitude: 60.740, longitude: 15.011),
]

let leksandsHoles = [
    Holes(number: 1, par: 3, index: 18, imageName: "ehole1"),
    Holes(number: 2, par: 4, index: 6, imageName: "hole2"),
    Holes(number: 3, par: 3, index: 16, imageName: "hole3"),
    Holes(number: 4, par: 5, index: 8, imageName: "hole4"),
    Holes(number: 5, par: 3, index: 18, imageName: "hole5"),
    Holes(number: 6, par: 5, index: 2, imageName: "hole6"),
    Holes(number: 7, par: 3, index: 14, imageName: "hole7"),
    Holes(number: 8, par: 4, index: 12, imageName: "hole8"),
    Holes(number: 9, par: 4, index: 4, imageName: "hole9"),
]

let leksandsGKTeePositions: [Int: CLLocationCoordinate2D] = [
    1: CLLocationCoordinate2D(latitude: 58.40199977960362, longitude: 15.564873846541612),
]

let leksandsGK = Course(holeLocations: leksandsHoleLocations, holes: leksandsHoles, image: "lgk", name: "Leksands GK", location:  CLLocationCoordinate2D(latitude: 60.75293270320932, longitude: 15.030893517190876), teePositions: leksandsGKTeePositions)

// Rättviks GK
let rattviksHoleLocations: [Int: CLLocationCoordinate2D] = [
    1: CLLocationCoordinate2D(latitude: 60.732, longitude: 15.003),
    2: CLLocationCoordinate2D(latitude: 60.733, longitude: 15.004),
    3: CLLocationCoordinate2D(latitude: 60.734, longitude: 15.005),
    4: CLLocationCoordinate2D(latitude: 60.735, longitude: 15.006),
    5: CLLocationCoordinate2D(latitude: 60.736, longitude: 15.007),
    6: CLLocationCoordinate2D(latitude: 60.737, longitude: 15.008),
    7: CLLocationCoordinate2D(latitude: 60.738, longitude: 15.009),
    8: CLLocationCoordinate2D(latitude: 60.739, longitude: 15.010),
    9: CLLocationCoordinate2D(latitude: 60.740, longitude: 15.011),
]

let rattviksHoles = [
    Holes(number: 1, par: 3, index: 18, imageName: "ehole1"),
    Holes(number: 2, par: 4, index: 6, imageName: "hole2"),
    Holes(number: 3, par: 3, index: 16, imageName: "hole3"),
    Holes(number: 4, par: 5, index: 8, imageName: "hole4"),
    Holes(number: 5, par: 3, index: 18, imageName: "hole5"),
    Holes(number: 6, par: 5, index: 2, imageName: "hole6"),
    Holes(number: 7, par: 3, index: 14, imageName: "hole7"),
    Holes(number: 8, par: 4, index: 12, imageName: "hole8"),
    Holes(number: 9, par: 4, index: 4, imageName: "hole9"),
]

let rattviksGKTeePositions: [Int: CLLocationCoordinate2D] = [
    1: CLLocationCoordinate2D(latitude: 58.40199977960362, longitude: 15.564873846541612),
]
let rattviksGK = Course(holeLocations: rattviksHoleLocations, holes: rattviksHoles, image: "rgk", name: "Rättviks GK", location:  CLLocationCoordinate2D(latitude: 60.89623326914897, longitude: 15.11122238286549), teePositions: rattviksGKTeePositions)

// Lidingö GK
let lidingoGKHoleLocations: [Int: CLLocationCoordinate2D] = [
        1: CLLocationCoordinate2D(latitude: 58.40199977960362, longitude: 15.564873846541612),
        2: CLLocationCoordinate2D(latitude: 58.401135871275926, longitude: 15.55880709410955),
        3: CLLocationCoordinate2D(latitude: 58.402102163942686, longitude: 15.556806523728074),
        4: CLLocationCoordinate2D(latitude: 58.40233285095422, longitude: 15.563865842904692),
        5: CLLocationCoordinate2D(latitude: 58.40266334196021, longitude: 15.566856366661721),
        6: CLLocationCoordinate2D(latitude: 58.403046074472144, longitude: 15.560014004601417),
        7: CLLocationCoordinate2D(latitude: 58.40345931733258, longitude: 15.562468434898701),
        8: CLLocationCoordinate2D(latitude: 58.40418108180549, longitude: 15.56873664131122),
        9: CLLocationCoordinate2D(latitude: 58.40141915456523, longitude: 15.569503177890752),
    ]

let lidingoGKHoles = [
    Holes(number: 1, par: 4, index: 10, imageName: "ehole1"),
    Holes(number: 2, par: 4, index: 6, imageName: "hole2"),
    Holes(number: 3, par: 3, index: 16, imageName: "hole3"),
    Holes(number: 4, par: 5, index: 8, imageName: "hole4"),
    Holes(number: 5, par: 3, index: 18, imageName: "hole5"),
    Holes(number: 6, par: 5, index: 2, imageName: "hole6"),
    Holes(number: 7, par: 3, index: 14, imageName: "hole7"),
    Holes(number: 8, par: 4, index: 12, imageName: "hole8"),
    Holes(number: 9, par: 4, index: 4, imageName: "hole9"),
]

let lidingoGKTeePositions: [Int: CLLocationCoordinate2D] = [
    1: CLLocationCoordinate2D(latitude: 58.401200979035984, longitude: 15.569810644007386),
    2: CLLocationCoordinate2D(latitude: 58.40208415830721, longitude: 15.56432471183862),
]

let lidingoGK = Course(holeLocations: lidingoGKHoleLocations, holes: lidingoGKHoles, image: "ligk", name: "Lidingö GK", location: CLLocationCoordinate2D(latitude: 58.40127382191677, longitude: 15.570044023848054), teePositions: linkopingGKTeePositions)

struct CourseRepository {
    static let allCourses: [Course] = [linkopingGK, leksandsGK, rattviksGK, lidingoGK]
}
