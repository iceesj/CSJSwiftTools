//
//  CSJSTLocationManager.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import CoreLocation

public typealias LocationHandler = (_ manager:CLLocationManager,_ location:CLLocation?) -> Void
public typealias FindCityHandler = (_ city:String?) -> Void

class CSJSTLocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedManager = CSJSTLocationManager()
    
    let locationManager = CLLocationManager()
    let geocoder     = CLGeocoder()
    var handler:LocationHandler?
    var findCityHandler:FindCityHandler?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    /**
     寻找城市
     */
    func findCity(_ handler:@escaping (_ city:String?) -> Void){
        self.locationManager.requestWhenInUseAuthorization()
        self.findCityHandler = handler
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    /**
     所需的精度
     */
    func locate(_ desiredAccuracy:CLLocationAccuracy = kCLLocationAccuracyBest, handler:LocationHandler? = nil){
        self.locationManager.requestWhenInUseAuthorization()
        self.handler = handler
        
        locationManager.desiredAccuracy = desiredAccuracy
    }
    
    /**
     反向地理编码位置
     */
    func reverseGeocodeLocation(_ location:CLLocation,handler:@escaping CLGeocodeCompletionHandler){
        geocoder.cancelGeocode()
        geocoder.reverseGeocodeLocation(location, completionHandler: handler)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.handler?(manager,locations.first)
        
        
        if findCityHandler != nil && locations.first != nil
        {
            manager.stopUpdatingLocation()
            
            self.reverseGeocodeLocation(locations.first!, handler: { (marks, error) in
                
                if let mark = marks?.first
                {
                    print(mark.locality ?? <#default value#>)
                    self.findCityHandler?(mark.locality)
                }
                
            })
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
            
        case .notDetermined:
            break;
        case .restricted:
            break;
        case .denied:
            break;
        case .authorizedAlways:
            break;
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break;
        }
    }
    
    
}
