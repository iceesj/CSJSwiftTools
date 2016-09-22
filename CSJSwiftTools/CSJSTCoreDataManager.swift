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
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore {
            (success, error) in
//            DDLogInfo("save in background: \(success) \(error)")
        }
    }
    
    /**
     saveInForeground
     */
    func saveInForeground() {
        //        NSManagedObjectContext.MR_defaultContext().MR_saveOnlySelfAndWait()
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
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
    func dictionaryFromManagedObject(_ managedObject : NSManagedObject?) -> NSMutableDictionary {
        guard managedObject != nil else{
            return NSMutableDictionary(capacity: 0)
        }
        let resultDict : NSMutableDictionary = NSMutableDictionary(capacity: 0)
        
        let attributesByName : NSDictionary = (managedObject?.entity.attributesByName)! as NSDictionary
        let valuesDictionary : NSDictionary = (managedObject?.dictionaryWithValues(forKeys: attributesByName.allKeys as! [String]))! as NSDictionary
        resultDict.setObject((managedObject?.entity.name)!, forKey: "ManagedObjectName" as NSCopying)
        
        for attr in valuesDictionary {
            let attrString : String = String(describing: attr)
            var value : AnyObject = valuesDictionary.value(forKey: attrString)! as AnyObject
            NSLog("value = \(value)")
            
            if value.isKind(of: NSDate.self) {
                let dateFormatter : DateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                value = dateFormatter.string(from: value as! Date) as AnyObject
                
            }
        }
        
        return resultDict
    }
    //*/

}
