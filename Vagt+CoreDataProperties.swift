//
//  Vagt+CoreDataProperties.swift
//  Føtex Løn
//
//  Created by Martin Lok on 07/08/2016.
//  Copyright © 2016 Martin Lok. All rights reserved.
//

import Foundation
import CoreData

extension Vagt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vagt> {
        return NSFetchRequest<Vagt>(entityName: "Vagt");
    }

    @NSManaged public var active: Bool
    @NSManaged public var note: String?
    @NSManaged public var startTime: Date!
    @NSManaged public var endTime: Date!
    @NSManaged public var pause: Int
    @NSManaged public var monthNumber: Double
    @NSManaged public var id: String!
    @NSManaged public var eventID: String?

}
