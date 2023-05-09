//
//  PlanetOffline+CoreDataProperties.swift
//  PlanetListTask
//
//  Created by Prajakta on 09/05/23.
//
//

import Foundation
import CoreData


extension PlanetOffline {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetOffline> {
        return NSFetchRequest<PlanetOffline>(entityName: "PlanetOffline")
    }

    @NSManaged public var rawData: Data?
    @NSManaged public var url: String?
    @NSManaged public var timeStamp: Date?

}

extension PlanetOffline : Identifiable {

}
