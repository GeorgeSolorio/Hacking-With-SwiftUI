//
//  MapView.swift
//  BucketList
//
//  Created by George Solorio on 9/22/20.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
   
   @Binding var centerCoordinate: CLLocationCoordinate2D
   @Binding var selectPlace: MKPointAnnotation?
   @Binding var showingPlaceDetail: Bool
   var annotations: [MKPointAnnotation]
   
   class Coordinator: NSObject, MKMapViewDelegate {
      
      var parent: MapView
      
      init(_ parent: MapView) {
         self.parent = parent
      }
      
      func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
         parent.centerCoordinate = mapView.centerCoordinate
      }
      
      func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
         
         // This is our unique identifier
         let identifier = "Placemark"
         
         // attempt to find a cell we can recycle
         var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
         
         if annotationView == nil {
            // we didn't find one; make a new one
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            // allot this to show pop up information
            annotationView?.canShowCallout = true
            
            // attach an information button to the view
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
         } else {
            
            // We have a view to reuse, so give it a new annotation
            annotationView?.annotation = annotation
         }
         
         return annotationView
      }
      
      func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
         
         guard let placemark = view.annotation as? MKPointAnnotation else { return }
         
         parent.selectPlace = placemark
         parent.showingPlaceDetail = true
      }
   }
   
   func makeUIView(context: Context) -> MKMapView {
      let mapView = MKMapView()
      mapView.delegate = context.coordinator
      return mapView
   }
   
   func updateUIView(_ view: MKMapView, context: Context) {
      if annotations.count != view.annotations.count {
         view.removeAnnotations(view.annotations)
         view.addAnnotations(annotations)
      }
   }
   
   func makeCoordinator() -> Coordinator {
      Coordinator(self)
   }
   
}

extension MKPointAnnotation {
   
   static var example: MKPointAnnotation {
      let annotation = MKPointAnnotation()
      annotation.title = "London"
      annotation.subtitle = "Home to the 2012 Summer Olympics."
      annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
      return annotation
   }
}
