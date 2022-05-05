//
//  Location.swift
//  MultiMap
//
//  Created by Herebiondev on 5/5/22.
//
//  As CLLocationCoordinate2D does not conform to Hashable out of the box,
//  making the coordinate a computed property allows us to get the protocol
//  synthesis and save some work.

import MapKit

struct Location: Hashable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
