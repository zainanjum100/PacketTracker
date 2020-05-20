//
//  MapView.swift
//  PacketTracker
//
//  Created by ZainAnjum on 14/05/2020.
//  Copyright © 2020 Noman2. All rights reserved.
//
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    var location = MKPointAnnotation()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        mapView.delegate = context.coordinator
        
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        
        print("location \(location.coordinate)")
        if location.coordinate.latitude != 0{
            view.addAnnotation(location)
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            view.setRegion(region, animated: true)
            print(location.coordinate)
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.canShowCallout = true
        return view
    }
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        print(mapView.centerCoordinate)
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }
}
extension MKPointAnnotation{
    static var example: MKPointAnnotation{
       let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Capital of England"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
        return annotation
    }
}
//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
//    }
//}
