//
//  MapView.swift
//  WhereIsIt
//
//  Created by Green T
//

import Foundation
import UIKit
import SwiftUI
import MapKit
import FirebaseFirestore
import CoreLocation

public var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 33.7756, longitude: -84.3963), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))

struct MapView: UIViewRepresentable {
    @Binding var selectedEntity: String
    @Binding var selectedBuilding: String?
    @Binding var entityLocationDescription: String?  // THIS IS USED TO UPDATE DESCRIPTION
    @Binding var showingBuildingDescription: Bool
    
    
    @StateObject private var viewModel = MapViewModel()
    var db = Firestore.firestore()
    typealias UIViewType = UIView
    
    // Coordinator class responsible for notifying when changes occur to MapView
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent:MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // Function that creates the MKMarkerAnnotationView for each MKAnnotation
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifer  = "Placemark"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifer)
            
            if annotation is MKUserLocation {
                // Used to block conversion of userLocation to a MKMarkerAnnotationView
                return nil
            } else {
                if annotationView == nil {
                    annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifer)
                    annotationView?.canShowCallout = true
                    annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                } else {
                    annotationView?.annotation = annotation
                }
                return annotationView
            }
        }
        
        // Adds Functionality to the (i) button on each MKMarkerAnnotationView
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation as? MKPointAnnotation else { return }
            parent.selectedBuilding = annotation.title!
            parent.entityLocationDescription = annotation.subtitle!
            //parent.entityLocationDescription = "LOCATION DESCRIPTION - Passed in from MapView.swift"
            parent.showingBuildingDescription = true
        }
    }
    
    // Helper to connect MapView to it's Delegate
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    // Creates the map and Adds all pins to it via database query
    func makeUIView(context: Context) -> UIView {
        var descriptionString: String = ""
        viewModel.checkIfLocationServiceIsEnabled()
        
        let view = UIView()
        
        let map = MKMapView()
        map.delegate = context.coordinator
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        
        view.addSubview(map)
        
        // DATABASE QUERY
        db.collection(selectedEntity).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    for building in buildingList {
                        if building.name == document.documentID {
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = building.coordinate
                            annotation.title = building.name
                            db.collection(selectedEntity).document(document.documentID).collection("1").getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    for item in querySnapshot!.documents {
                                        descriptionString = descriptionString + "\(item.data().values.first!)\n"
                                    }
                                    annotation.subtitle = descriptionString
                                }
                            }
                            map.addAnnotation(annotation)
                            break
                        }
                    }
                }
            }
        }
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor),
            map.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            map.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
        
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //do nothing
    }
}


// LocationManager handles location permission services
final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        } else {
            print("TODO: Show an alert telling user to turn location on!")
        }
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    // Function that handles various location permissions
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        @unknown default:
            break;
        }
    }
}





// Helper to show an example of MKPointAnnotation
extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "Example Building"
        annotation.subtitle = "This is an example"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 33.7756, longitude: -84.3963)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(selectedEntity: .constant("testing"),
                selectedBuilding: .constant(MKPointAnnotation.example.title!),
                entityLocationDescription: .constant("Building Description"),
                showingBuildingDescription: .constant(false))
    }
}
