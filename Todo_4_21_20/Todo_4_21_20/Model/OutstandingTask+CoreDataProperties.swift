//
//  OutstandingTask+CoreDataProperties.swift
//  Todo_4_21_20
//
//  Created by EricM on 4/26/20.
//  Copyright © 2020 EricM. All rights reserved.
//
//

import Foundation
import CoreData


extension OutstandingTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OutstandingTask> {
        return NSFetchRequest<OutstandingTask>(entityName: "OutstandingTask")
    }

    @NSManaged public var name: String?
    @NSManaged public var uuid: UUID?

}
