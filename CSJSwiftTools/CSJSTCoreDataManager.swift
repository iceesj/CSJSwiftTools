//
//  CSJSTCoreDataManager.swift
//  CSJSwiftToolsDemo
//
//  Created by tom on 16/7/8.
//  Copyright © 2016年 caoshengjie. All rights reserved.
//

import UIKit
import Foundation
import MagicalRecord

class CSJSTCoreDataManager: NSObject {
    static let sharedInstance = CSJSTCoreDataManager()
    
    static func config() {
        //        MagicalRecord.setupCoreDataStackWithAutoMigratingSqliteStoreNamed("xs1h")
        MagicalRecord.setupAutoMigratingCoreDataStack()
    }
    
    /**
     cleanup
     */
    static func cleanup() {
        MagicalRecord.cleanUp()
    }
    
    /**
     saveInBackground
     */
    func saveInBackground() {
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreWithCompletion {
            (success, error) in
//            DDLogInfo("save in background: \(success) \(error)")
        }
    }
    
    /**
     saveInForeground
     */
    func saveInForeground() {
        //        NSManagedObjectContext.MR_defaultContext().MR_saveOnlySelfAndWait()
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    /**
     Methods retrieving data from local data base (Core Data)
     */
    
    /**
     Truncate all data
     */
//    func truncateData() {
//        XXX.MR_truncateAll()
//    }
    
    ///*
    func dictionaryFromManagedObject(managedObject : NSManagedObject?) -> NSMutableDictionary {
        guard managedObject != nil else{
            return NSMutableDictionary(capacity: 0)
        }
        let resultDict : NSMutableDictionary = NSMutableDictionary(capacity: 0)
        
        let attributesByName : NSDictionary = (managedObject?.entity.attributesByName)!
        let valuesDictionary : NSDictionary = (managedObject?.dictionaryWithValuesForKeys(attributesByName.allKeys as! [String]))!
        resultDict.setObject((managedObject?.entity.name)!, forKey: "ManagedObjectName")
        
        for attr in valuesDictionary {
            let attrString : String = String(attr)
            var value : AnyObject = valuesDictionary.valueForKey(attrString)!
            NSLog("value = \(value)")
            
            if value.isKindOfClass(NSDate.self) {
                let dateFormatter : NSDateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                value = dateFormatter.stringFromDate(value as! NSDate)
                
            }
        }
        
        return resultDict
    }
    //*/

}
