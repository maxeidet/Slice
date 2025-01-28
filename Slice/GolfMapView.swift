//
//  GolfMapView.swift
//  Slice
//
//  Created by Max Eidet on 2025-01-28.
//
import SwiftUI
import MapKit
import CoreLocation

struct GolfMapView: View {
    @State private var region: MKCoordinateRegion
    @State private var showInfo = false
    @State private var isExpanded = false
    @State private var showPopup = false
    @State private var selectedShot: Shot?
    @State private var currentShotIndex: Int = -1
    @Environment(\.dismiss) var dismiss
    let shots: [Shot]
    let course: Course

    init(shots: [Shot], course: Course) {
        self.course = course
        if let firstShot = shots.first {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: firstShot.latitude, longitude: firstShot.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
            ))
        } else {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
                span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            ))
        }
        self.shots = shots
    }

    var body: some View {
        ZStack {
            // Map View
            Map(coordinateRegion: $region, annotationItems: shots) { shot in
                MapAnnotation(
                    coordinate: CLLocationCoordinate2D(latitude: shot.latitude, longitude: shot.longitude)
                ) {
                    Button(action: {
                        selectedShot = shot
                        withAnimation {
                            showPopup = true
                        }
                    }) {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.greenApp)
                    }
                    .background(.white)
                    .clipShape(Circle())
                }
            }
            .mapStyle(.imagery)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
                    // Very bad solution maybe fix!?!?
                }
                .frame(height: 1)
                
                HStack {
                    if !isExpanded {
                        Button(action: {
                            withAnimation(.snappy) {
                                dismiss()
                            }
                        }) {
                            Image(systemName: "arrow.left")
                                .imageScale(.large)
                                .foregroundStyle(.white)
                        }
                       
                        Spacer()
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                                currentShotIndex = 0
                            }
                        }) {
                          
                            Image(systemName: "line.3.horizontal")
                                .foregroundStyle(.black)
                                .frame(width: 40, height: 40)
                                .background(.white)
                                .cornerRadius(10)
                        }
                    
                    }
                    
                    
                    if isExpanded {
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                                currentShotIndex = 0
                            }
                        }) {
                            
                            Image(systemName: "xmark")
                                .foregroundStyle(.black)
                                .frame(width: 40, height: 40)
                        }
                        HStack {
                            Text("Currently viewing: ")
                            Text(currentShotIndex == -1 ? "All holes" : "Shot \(currentShotIndex + 1)")
                        }
                        .font(.subheadline)
                        Spacer()
                        
                        Button(action: {
                            showNextShot()
                        }){
                            HStack {
                                Text("Next")
                                    .font(.subheadline)
                                Image(systemName: "arrow.right")
                                    
                            }
                            .padding()
                        }
                        .foregroundStyle(.black)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(isExpanded ? Color.white : Color.clear)
                .cornerRadius(12)
                .animation(.easeInOut, value: isExpanded)
                .padding()
                
                
                
                if showPopup, let shot = selectedShot {
                    VStack {
                        Button(action: {
                            showPopup = false
                        }) {
                            Image(systemName: "xmark.circle")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding()
                        
                        VStack {
                            Text("Hole \(shot.holeNumber), Shot \(shot.shotNumber)")
                                .font(.headline)
                                
                            
                            if let distance = calculateDistance(for: shot) {
                                Text("Distance: \(String(format: "%.1f", distance)) meters")
                                    .font(.subheadline)
                            } else {
                                Text("Distance: N/A")
                                    .font(.subheadline)
                                    
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    }
                }
                Spacer()
                
                HStack {
                    Spacer()
                    // Question Mark Button
                    Button(action: {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }) {
                        
                        Image(systemName: "questionmark")
                            .foregroundStyle(Color(.black))
                        
                    }
                    .frame(width: 60, height: 60)
                    .background(.white)
                    .clipShape(Circle())
                    
                }
                .opacity(showInfo ? 0 : 1)
                .padding()
            }
            
            
            if showInfo {
                VStack {
                    Text("Information")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(.top)
                    
                    Text("To view your shots for a specific hole, simply select the desired hole using the filter icon.")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding()
                    
                    Button(action: {
                        withAnimation {
                            showInfo.toggle()
                        }
                    }) {
                        Text("Close")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.greenApp)
                            .cornerRadius(12)
                    }
                    
                }
                .frame(maxWidth: 300)
                .padding()
                .background(Color.white.opacity(1))
                .cornerRadius(12)
                .shadow(radius: 10)
                .transition(.scale)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        
    }
    
    private func calculateDistance(for shot: Shot) -> Double? {
        if shot.shotNumber == 1, let teePosition = course.teePositions[shot.holeNumber] {
            // Calculate distance from tee position if it's the first shot on the hole
            let teeLocation = CLLocation(latitude: teePosition.latitude, longitude: teePosition.longitude)
            let shotLocation = CLLocation(latitude: shot.latitude, longitude: shot.longitude)
            return teeLocation.distance(from: shotLocation)
        } else {
            // Calculate distance from the previous shot
            guard let currentIndex = shots.firstIndex(where: { $0.id == shot.id }),
                  currentIndex > 0 else {
                return nil
            }
            
            let previousShot = shots[currentIndex - 1]
            let currentLocation = CLLocation(latitude: shot.latitude, longitude: shot.longitude)
            let previousLocation = CLLocation(latitude: previousShot.latitude, longitude: previousShot.longitude)
            return currentLocation.distance(from: previousLocation)
        }
    }
    
    private func showNextShot() {
        if shots.isEmpty { return }
        
        if selectedShot == nil {
            currentShotIndex = 0
        } else {
            
            currentShotIndex = (currentShotIndex + 1) % shots.count
        }
        
        selectedShot = shots[currentShotIndex]
        showPopup = true
        
        // Center the map on the selected shot
        if let selectedShot = selectedShot {
            region.center = CLLocationCoordinate2D(latitude: selectedShot.latitude, longitude: selectedShot.longitude)
        }
    }
}

#Preview {
    let mockShots = [

        Shot(holeNumber: 1, shotNumber: 1, latitude: 58.401394842084194, longitude: 15.566985744961919),
        Shot(holeNumber: 1, shotNumber: 2, latitude: 58.40179933198633, longitude: 15.565249477216707),
        Shot(holeNumber: 1, shotNumber: 3, latitude: 58.40199553526756, longitude: 15.564907567829115),

     
        Shot(holeNumber: 2, shotNumber: 1, latitude: 58.40120641330053, longitude: 15.562332240600057),
        Shot(holeNumber: 2, shotNumber: 2, latitude: 58.40127176130382, longitude: 15.560216203618987),
        Shot(holeNumber: 2, shotNumber: 3, latitude: 58.401264100302086, longitude: 15.558860090736307),
        Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712),
        Shot(holeNumber: 3, shotNumber: 1, latitude: 58.40208360199551, longitude: 15.556984825520628)
    ]

    return GolfMapView(shots: mockShots, course: linkopingGK)
}
