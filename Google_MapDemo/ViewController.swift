//
//  ViewController.swift
//  Google_MapDemo
//
//  Created by Smita Kankayya on 23/01/24.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    
    var gmsCameraPosition : GMSCameraPosition?
    var delhiPosition : CLLocationCoordinate2D?
    var bitcodeMarker : GMSMarker = GMSMarker(
        position: CLLocationCoordinate2D(
            latitude: 18.5091,
            longitude: 73.8326))
    var delhiMarker : GMSMarker?
    var gmsCircle : GMSCircle?
    var radiusOfCircle : CLLocationDistance?
    var gmsPolygon : GMSPolygon?
    var gmsPolyline : GMSPolyline?
    var gmsMutablePathForPolygon : GMSMutablePath?
    var gmsMutablePathForPolyline : GMSMutablePath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delhiPosition = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
        delhiMarker = GMSMarker(position: delhiPosition!)
        
        initializeMarker(marker: delhiMarker!)
        initializeMarker(marker: bitcodeMarker)
        settingCameraPosition(position: bitcodeMarker.position)
        initializeSettingsForGoogleMaps()
        
        drawCircleOnMap(position: delhiMarker!.position, radius: 200000.0)
        drawPolygonOnMap()
        drawPolylineOnMap()
    }
    
    func initializeMarker(marker: GMSMarker!){
        //marker.snippet = "Bitcode Tech"
        marker.rotation = 45.0
        marker.opacity = 1
        marker.isDraggable = true
        //marker.title = "Bitcode"
        marker.zIndex = 5
        marker.map = googleMapView
        
    }
    
    func settingCameraPosition(position: CLLocationCoordinate2D){
        gmsCameraPosition = GMSCameraPosition(target: position, zoom: 5.0)
        googleMapView.camera = gmsCameraPosition!
        
    }
    
    func initializeSettingsForGoogleMaps(){
        googleMapView.delegate = self
        googleMapView.settings.myLocationButton = true
        googleMapView.settings.compassButton = true
        googleMapView.settings.zoomGestures = true
        googleMapView.settings.rotateGestures = true
        googleMapView.settings.scrollGestures = true
        googleMapView.settings.tiltGestures = true
        googleMapView.isBuildingsEnabled = true
        googleMapView.isTrafficEnabled = true
        googleMapView.isMyLocationEnabled = true
        googleMapView.mapType = .normal
        
    }
    
    func drawCircleOnMap(position: CLLocationCoordinate2D, radius : CLLocationDistance){
        gmsCircle = GMSCircle(position: position,radius: radius)
        gmsCircle?.zIndex = 5
        gmsCircle?.title = "Delhi State"
        gmsCircle?.fillColor = .cyan
        gmsCircle?.strokeColor = .purple
        gmsCircle?.strokeWidth = 2.0
        gmsCircle?.map = googleMapView
        
    }
    
    func drawPolygonOnMap(){
        gmsMutablePathForPolygon = GMSMutablePath()
        gmsMutablePathForPolygon?.add(CLLocationCoordinate2D(latitude: 19.9975, longitude: 73.7898))
        gmsMutablePathForPolygon?.add(CLLocationCoordinate2D(latitude: 19.8762 , longitude: 75.3433))
        gmsMutablePathForPolygon?.add(CLLocationCoordinate2D(latitude: 17.6599, longitude: 75.9064))
        gmsMutablePathForPolygon?.add(CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567))
        gmsPolygon = GMSPolygon(path: gmsMutablePathForPolygon)
        gmsPolygon?.strokeWidth = 5.0
        gmsPolygon?.strokeColor = .brown
        gmsPolygon?.fillColor = .lightGray
        gmsPolygon?.title = " Cities in Maharashtra"
        gmsPolygon?.zIndex = 2
        gmsPolygon?.map = googleMapView
    }
    
    func drawPolylineOnMap(){
        gmsMutablePathForPolyline = GMSMutablePath()
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 21.1458, longitude: 79.0882))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 19.9615, longitude: 79.2961))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 19.6766, longitude: 78.5321))
        gmsMutablePathForPolyline?.add(CLLocationCoordinate2D(latitude: 20.3839, longitude: 78.1307))
        gmsPolyline = GMSPolyline(path: gmsMutablePathForPolyline)
        gmsPolyline?.strokeColor = .blue
        gmsPolyline?.strokeWidth = 5.0
        gmsPolyline?.title = " Cities"
        gmsPolyline?.zIndex = 10
        gmsPolyline?.map = googleMapView
    }
    
}
//MARK : GMSMapViewDelegate
extension ViewController : GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        print("Close info window")
    }
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        
        let infoWindowRect = CGRect(x: 0,y: 0,width: 200,height: 160)
        var infoWindowView = UIView(frame: infoWindowRect)
        infoWindowView.backgroundColor = .cyan
        
        let labelOneRect = CGRect(x: 20,y: 20,width:140,height: 40)
        
        var labelOne = UILabel(frame: labelOneRect)
        labelOne.text = "Welcome To"
        labelOne.backgroundColor = .lightGray
        labelOne.textColor = .black
        
        let labelTwoRect = CGRect(x: 20,y: 100,width: 140,height: 40)
        
        var labelTwo = UILabel(frame: labelTwoRect)
        labelTwo.text = "Bitcode"
        labelTwo.backgroundColor = .lightGray
        labelTwo.textColor = .black
        
        infoWindowView.addSubview(labelOne)
        infoWindowView.addSubview(labelTwo)
        
        return infoWindowView
    }
    
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print(marker.position)
    }
    
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print(marker.position)
    }
    
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print(marker.position)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        print("long press -- \(coordinate.latitude) -- \(coordinate.longitude)")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("did Tap At --\(coordinate.latitude) -- \(coordinate.longitude)")
    }
}









