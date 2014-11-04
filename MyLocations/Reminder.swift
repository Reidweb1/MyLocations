//
//  Reminder.swift
//  MyLocations
//
//  Created by Reid Weber on 11/4/14.
//  Copyright (c) 2014 Reid Weber. All rights reserved.
//

import Foundation
import CoreData

class Reminder: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var name: String
    @NSManaged var radius: NSNumber

}
