//
//  WRMapController.swift
//  WeatherReport
//
//  Created by Hetal Patel on 21/01/21.
//

import UIKit
import MapKit
import ObjectMapper

protocol MapViewDelegate {
    func onSelectedMapLocation(location: CLLocation)
}
class WRMapController: UIViewController {
    
    @IBOutlet weak var locationsMAp: MKMapView!
    @IBOutlet weak var saveButton: UIButton!
    let locationManager = CLLocationManager()
    var selectedLocation: CLLocation?
    var mapViewDelegate: MapViewDelegate?
    var homedelegate: HomeViewDelegate?
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setRadius()
        self.setpinToTap()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
    
    func setRadius()
    {
        self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height/2
        self.saveButton.clipsToBounds = true
        self.setshadow()
    }
    func setshadow()
    {
        saveButton.layer.shadowColor = UIColor.blue.cgColor//UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        saveButton.layer.shadowOpacity = 1.0
        saveButton.layer.shadowRadius = 10.0
        saveButton.layer.masksToBounds = false
    }
    //MARK: Actions
    
    @IBAction func saveClick(_ sender: Any) {
        self.getWeatherData(annotation.coordinate.latitude, annotation.coordinate.longitude)
    }
}
extension WRMapController
{
    //MARK: PinOnTap
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: locationsMAp)
        let coordinate = locationsMAp.convert(location, toCoordinateFrom: locationsMAp)
        
        // Add annotation:
        annotation.coordinate = coordinate
        locationsMAp.addAnnotation(annotation)
    }
    func setpinToTap()
    {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap(gestureRecognizer:)))
        locationsMAp.addGestureRecognizer(gestureRecognizer)
    }
}
extension WRMapController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            if let currentLocation = locations.first {
                if let mapViewDelegate = mapViewDelegate {
                    mapViewDelegate.onSelectedMapLocation(location: currentLocation)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}
extension WRMapController
{
    //MARK: API
    func getWeatherData(_ lat : Double , _ long : Double)
    {
        WRProgressHUDManager.showKRProgressHUD(true)
        let URL = "\(APIName.APIWeather)lat=\(lat)&lon=\(long)&appid=\(Keys.APIKeys)"
        
        WRAPIManager.manager.getAPI(APIName: URL, params:[:], success: { (response) in
            DispatchQueue.main.async {
                debugPrint(response.count)
                let appDataRes = Mapper<Response>().map(JSON: response)
                debugPrint(appDataRes?.coord ?? Coord())
                forecastData.append(appDataRes ?? Response())
                WRAppManager.shared.setBookmarkUserDefault(bookmark: forecastData)
                if self.homedelegate != nil {
                    self.homedelegate?.didUpdate()
                }
                self.dismissPopUpViewController {
                }
                WRProgressHUDManager.showKRProgressHUD(false)
            }
        }) { (error) in
            DispatchQueue.main.async {
                WRProgressHUDManager.showKRProgressHUD(false)
                self.showAlert(title: Strings.AlertTitle, message: Strings.FailureOperation)
            }
        }
    }
}
