//
//  ContentView.swift
//  MultiMap
//
//  Created by Herebiondev on 5/5/22.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    // Store the user text if the user quits the app without
    // having completed their current search
    @AppStorage("searchText") private var searchText = ""
    
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
    
    @State private var locations = [Location]()
    @State private var selectedLocations = Set<Location>()
    
    var body: some View {
        NavigationView {
            List(
                locations,
                selection: $selectedLocations
            ) { location in
                Text(location.name)
                    .tag(location)
                    .contextMenu {
                        Button("Delete", role: .destructive) {
                            delete(location)
                        }
                    }
            }
            .frame(minWidth: 200)
            .onDeleteCommand {
                for location in selectedLocations {
                    delete(location)
                }
            }
            
            // Map
            VStack {
                HStack {
                    TextField("Search for something...", text: $searchText)
                        .onSubmit(runSearch)
                    
                    Button("Go", action: runSearch)
                }
                .padding([.top, .horizontal])
                
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
            .onChange(of: selectedLocations) { _ in
                var visibleMap = MKMapRect.null
                
                // The 100,000 and 200,000 are there to ensure we don't
                // focus too tightly on each location, otherwise having just
                // one location selected would zoom in so tightly that users
                // would have no idea what they were looking at.
                for location in selectedLocations {
                    let mapPoint = MKMapPoint(location.coordinate)
                    let pointRect = MKMapRect(
                        x: mapPoint.x - 100_000,
                        y: mapPoint.y - 100_000,
                        width: 200_000,
                        height: 200_000
                    )
                    
                    visibleMap = visibleMap.union(pointRect)
                }
                
                var newRegion = MKCoordinateRegion(visibleMap)
                
                // Add some extra padding around our locations
                newRegion.span.latitudeDelta *= 1.5
                newRegion.span.longitudeDelta *= 1.5
                
                withAnimation {
                    region = newRegion
                }
        }
        }
    }
    
    func delete(_ location: Location) {
        guard let index = locations.firstIndex(of: location) else { return }
        locations.remove(at: index)
    }
    
    func runSearch() {
        // Search Request Configuration
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
            // Pass our existing map region as the location hint
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        // Start the search
        search.start { response, error in
            
            // Check if we have a valid response from the map
            guard let response = response else { return }
            
            // Make our closure bail out if we could read the first result
            guard let item = response.mapItems.first else { return }
            
            guard let itemName = item.name,
                  let itemLocation = item.placemark.location
            else { return }
            
            let newLocation = Location(
                name: itemName,
                latitude: itemLocation.coordinate.latitude,
                longitude: itemLocation.coordinate.longitude
            )
            withAnimation {
                locations.append(newLocation)
                selectedLocations = [newLocation]
                searchText = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
