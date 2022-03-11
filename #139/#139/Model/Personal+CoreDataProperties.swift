//
//  Personal+CoreDataProperties.swift
//  #139
//
//  Created by Lan Ran on 2022/3/10.
//
//

import Foundation
import CoreData


extension Personal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Personal> {
        return NSFetchRequest<Personal>(entityName: "Personal")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var largePic: String?
    @NSManaged public var gender: String?

}

extension Personal : Identifiable {

}
