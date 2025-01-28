//
//  GolfMapView.swift
//  Slice
//
//  Created by Max Eidet on 2025-01-28.
//
import SwiftUI
import MapKit

struct GolfMapView: View {
    @State private var region: MKCoordinateRegion
    @State private var showInfo = false
    @State private var isExpanded = false
    let shots: [Shot]

    init(shots: [Shot]) {
        if let firstShot = shots.first {
            _region = State(initialValue: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: firstShot.latitude, longitude: firstShot.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            ))
        } else {
            // Default region if no shots
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
                        MapMarker(
                            coordinate: CLLocationCoordinate2D(latitude: shot.latitude, longitude: shot.longitude),
                            tint: .blue
                        )
                    }
                    .mapStyle(.imagery)
                    .edgesIgnoringSafeArea(.all)

                    VStack {
                        VStack {
                            // Very bad solution maybe fix!?!?
                        }
                        .frame(height: 1)
                        
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isExpanded.toggle()
                                }
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundStyle(.black)
                                    .frame(width: 40, height: 40)
                                    .background(.white)
                                    .cornerRadius(10)
                            }
                            Spacer()
                            if isExpanded {
                                Text("See hole 1")
                                    .padding()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .background(isExpanded ? Color.white : Color.clear) // Change background based on state
                        .cornerRadius(10)
                        .animation(.easeInOut, value: isExpanded) // Smooth transition
                        .padding()
                       
                       
                        
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
                        .padding()
                    }

                    // Information Container
                    if showInfo {
                        VStack {
                            Text("Information")
                                .font(.title2)
                                .foregroundColor(.black)
                                .padding(.top)

                            Text("To view your shots for a specific hole, simply select the desired hole using the filter icon.")
                                .multilineTextAlignment(.center)
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
                                    .cornerRadius(8)
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
        Shot(holeNumber: 2, shotNumber: 4, latitude: 58.40113577407895, longitude: 15.558788189566712)
    ]

    return GolfMapView(shots: mockShots)
}
