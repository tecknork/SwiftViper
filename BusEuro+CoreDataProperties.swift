//
//  BusEuro+CoreDataProperties.swift
//  GoEuroTest
//
//  Created by Murtaza Raza  on 18/11/2016.
//  Copyright © 2016 Murtaza Raza. All rights reserved.
//

import Foundation
import CoreData


extension BusEuro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusEuro> {
        return NSFetchRequest<BusEuro>(entityName: "BusEuro");
    }

    @NSManaged public var arrival_time: String?
    @NSManaged public var departure_time: String?
    @NSManaged public var id: Int32
    @NSManaged public var number_of_stops: Int16
    @NSManaged public var price_euro: Double
    @NSManaged public var logo: String?

}
