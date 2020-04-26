//
//  CompletedTask+CoreDataProperties.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/26/20.
//  Copyright © 2020 EricM. All rights reserved.
//
//

import Foundation
import CoreData


extension CompletedTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompletedTask> {
        return NSFetchRequest<CompletedTask>(entityName: "CompletedTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var relationship: NSManagedObject?

}
