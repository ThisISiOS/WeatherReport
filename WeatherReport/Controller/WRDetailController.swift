//
//  WRDetailController.swift
//  WeatherReport
//
//  Created by Hetal Patel on 21/01/21.
//

import UIKit
import MapKit

class WRDetailController: UIViewController {
    
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tempratureMaxLabel: UILabel!
    @IBOutlet weak var tempratureMinLabel: UILabel!
    @IBOutlet weak var cloudLabel: UILabel!
    @IBOutlet weak var locationMap: MKMapView!
    var foreCastData : Response?
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setValues()
        self.setMap()
    }
    func setValues()
    {
        if let weatherMain = self.foreCastData?.weather?[0]
        {
            self.cloudLabel.text = ("\(weatherMain.main ?? ""): \(weatherMain.description ?? "")")
        }
        if let temp = self.foreCastData?.main
        {
            if let min = temp.temp_min , let max = temp.temp_max
            {
                tempratureMinLabel.text = ("\(Strings.tempMin): \(min )")
                tempratureMaxLabel.text = ("\(Strings.tempMax): \(max )")
            }
        }
        if (self.foreCastData?.wind) != nil
        {
            self.windLabel.text = ("\(Strings.WindString): \(self.foreCastData?.wind?.speed ?? 0.0) \(Strings.WindUnit)")
        }
        
    }
    func setMap()
    {
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.foreCastData?.coord?.lat ?? 0.0, longitude: self.foreCastData?.coord?.lon ?? 0.0)
        locationMap.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        locationMap.setRegion(region, animated: true)
    }
}
