//
//  CSJSTLocationManager.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/11.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import CoreLocation

public typealias LocationHandler = (manager:CLLocationManager,location:CLLocation?) -> Void
public typealias FindCityHandler = (city:String?) -> Void

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
    func findCity(handler:(city:String?) -> Void){
        self.locationManager.requestWhenInUseAuthorization()
        self.findCityHandler = handler
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    /**
     所需的精度
     */
    func locate(desiredAccuracy:CLLocationAccuracy = kCLLocationAccuracyBest, handler:LocationHandler? = nil){
        self.locationManager.requestWhenInUseAuthorization()
        self.handler = handler
        
        locationManager.desiredAccuracy = desiredAccuracy
    }
    
    /**
     反向地理编码位置
     */
    func reverseGeocodeLocation(location:CLLocation,handler:CLGeocodeCompletionHandler){
        geocoder.cancelGeocode()
        geocoder.reverseGeocodeLocation(location, completionHandler: handler)
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.handler?(manager: manager,location:locations.first)
        
        
        if findCityHandler != nil && locations.first != nil
        {
            manager.stopUpdatingLocation()
            
            self.reverseGeocodeLocation(locations.first!, handler: { (marks, error) in
                
                if let mark = marks?.first
                {
                    print(mark.locality)
                    self.findCityHandler?(city: mark.locality)
                }
                
            })
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
            
        case .NotDetermined:
            break;
        case .Restricted:
            break;
        case .Denied:
            break;
        case .AuthorizedAlways:
            break;
        case .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break;
        }
    }
    
    
}
