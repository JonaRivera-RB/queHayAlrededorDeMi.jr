//
//  mapKitVc.swift
//  eatingApp
//
//  Created by misael rivera on 05/01/18.
//  Copyright © 2018 misael rivera. All rights reserved.
//

import UIKit
import MapKit

class mapKitVc: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapkitView: MKMapView!
    
      var latitud:Double = 0.0
      var longitud:Double = 0.0
      var nombre:String = ""
    
    @IBOutlet weak var lblminutos: UILabel!
    @IBOutlet weak var lblkilometors: UILabel!
    let locationmanager = CLLocationManager()
    
    var destCoordinates:CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cargarlogo()
        
        mapkitView.delegate = self
        mapkitView.showsScale = true
        mapkitView.showsPointsOfInterest = true
        mapkitView.showsUserLocation = true
        mapkitView.userLocation.title = "Aqui mero estas"
        
        locationmanager.requestAlwaysAuthorization()
        locationmanager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = kCLLocationAccuracyBest
            locationmanager.startUpdatingLocation()
        }
        
        let sourceCoordinates = locationmanager.location?.coordinate
         destCoordinates = CLLocationCoordinate2DMake(latitud, longitud)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates!)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .automobile
        
      
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            guard let response = response else {
                if let error = error {
                    print("algo salio mal\(error)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapkitView.addOverlay(route.polyline, level: .aboveRoads)
            self.lblminutos.text = String("\(Int(route.expectedTravelTime/60.0)) min")
            let kilometros = route.distance/1000
           // String(format: "%.2f", currentRatio)
            self.lblkilometors.text = String(format: "%.1f", kilometros) + " Km"
            print("distancia en metros>\(String(describing: self.lblkilometors))")
            let rekt = route.polyline.boundingMapRect
            self.mapkitView.setRegion(MKCoordinateRegion.init(rekt), animated: true)
        })
 
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitud, longitud)
        annotation.title = nombre
        annotation.subtitle = "Aqui mero quieres llegar"
        mapkitView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func cargarlogo()
    {
        let logo = UIImage(named: "phood_logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
    }
    
    //open the map
    @IBAction func showMap(_ sender: Any) {
        let regionDistance:CLLocationDistance = 1000;
        let regionSpan = MKCoordinateRegion(center: destCoordinates!,latitudinalMeters: regionDistance,longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placeMark = MKPlacemark(coordinate: destCoordinates!)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = "Mi destino"
        mapItem.openInMaps(launchOptions: options)
    }
    
    
}
