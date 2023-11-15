//
//  CDProfile+CoreDataProperties.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData


extension CDProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProfile> {
        return NSFetchRequest<CDProfile>(entityName: "CDProfile")
    }

    @NSManaged public var id: String
    @NSManaged public var nickname: String
    @NSManaged public var email: String
    @NSManaged public var avatarLink: String
    @NSManaged public var name: String
    @NSManaged public var birthDate: Date
    @NSManaged public var gender: String

}

extension CDProfile : Identifiable {

}
