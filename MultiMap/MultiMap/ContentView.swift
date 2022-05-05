//
//  ContentView.swift
//  MultiMap
//
//  Created by Herebiondev on 5/5/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    // Default region of the map
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.507222,
            longitude: -0.1275
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5
        )
    )
    
    let locations = [
        Location(
            name: "London",
            latitude: 51.507222,
            longitude: -0.1275
        ),
        Location(
            name: "Glasgow",
            latitude: 55.8616752,
            longitude: -4.2546099
        )
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Text(location.name)
                    .font(.headline)
                    .padding(5)
                    .padding(.horizontal, 5)
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
