//
//  LocationManager.swift
//  Slice
//
//  Created by Max Eidet on 2024-11-27.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @Published var distance: Double?
    @Published var errorMsg: String?
    
    private var greenLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func startUpdatingLocation(to greenLocation: CLLocationCoordinate2D) {
        self.greenLocation = greenLocation
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.errorMsg = "Tillstånd att komma åt plats nekades"
            }
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last, let greenLocation = greenLocation else { return }
        
        let greenCLLocation = CLLocation(latitude: greenLocation.latitude, longitude: greenLocation.longitude)
        let distance = currentLocation.distance(from: greenCLLocation)
        
        DispatchQueue.main.async {
            self.distance = distance
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMsg = "Kunde inte hämta platsinformation"
        }
        stopUpdatingLocation()
    }
    
    func calculateDistances(to courses: [Course], from currentLocation: CLLocationCoordinate2D) -> [String: Double] {
        let userLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        var distances: [String: Double] = [:]
        
        for course in courses {
            let courseLocation = CLLocation(latitude: course.location.latitude, longitude: course.location.longitude)
            let distance = userLocation.distance(from: courseLocation)
            distances[course.name] = distance
        }
        
        return distances
    }
}
