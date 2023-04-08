//
//  MapModels.swift
//  Shin-ShareFootPrint
//
//  Created by Yuki-OHMORI on 2023/04/04.
//

import UIKit
import MapKit
import Combine//new
import CoreLocation//new

class LocationManager: NSObject,ObservableObject,CLLocationManagerDelegate {
    let manager = CLLocationManager()
    @Published var locationInfos = LocationStruct(latitude: [], longitude: [], locations: [])
    
    @Published var region = MKCoordinateRegion()
    
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 3.0
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let longitude = manager.location?.coordinate.longitude{
            locationInfos.longitude.append(longitude)
            if let latitude = manager.location?.coordinate.latitude{
                locationInfos.latitude.append(latitude)
                locationInfos.locations.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                objectWillChange.send()
            }
        }
        locations.last.map{
            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            region = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000.0,
                longitudinalMeters: 1000.0
            )
        }
//        print("MapModels:\(locationInfos.latitude)")
    }
}
