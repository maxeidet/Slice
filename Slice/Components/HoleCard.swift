//
//  HoleCard.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import SwiftUI
import CoreLocation

struct HoleCard: View {
    let holeNumber: Int
    let par: Int
    let index: Int
    let imageName: String
    let greenLocation: CLLocationCoordinate2D
    @ObservedObject var locationManager = LocationManager ()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        Text("\(holeNumber)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .frame(width: 80)
                    Spacer()
                    Divider()
                        .background(.black)
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Par: \(par)")
                            .font(.subheadline)
                        
                        Text("Index: \(index)")
                            .font(.subheadline)
                        
                    
                        if let distance = locationManager.distance {
                            Text("Distance: \(String(format: "%.0f", distance))m")
                                .font(.subheadline)
                        } else {
                            VStack {
                                Image(systemName: "cellularbars")
                                    .foregroundStyle(Color(.red))
                                Text("Calculating distance...")
                                    .font(.subheadline)
                               
                            }
                           
                        }
                    }
                    .frame(width: 150)
                }
                .padding()
                .frame(width: 250, height: 100)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 2)
                .padding()
            }
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 400)
        }
        .onAppear {
                    locationManager.startUpdatingLocation(to: greenLocation)
                }
        .onDisappear {
                    locationManager.stopUpdatingLocation()
                }
    }
    
    
}

#Preview {
    HoleCard(
        holeNumber: 1,
        par: 4,
        index: 11,
        imageName: "hole1",
        greenLocation: CLLocationCoordinate2D(latitude: 59.3293, longitude: 18.0686)
    )
}
