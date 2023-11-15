//
//  CDGenre+CoreDataClass.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData

@objc(CDGenre)
public class CDGenre: NSManagedObject {

    func toDomain() -> Genre {
        .init(id: id, name: name)
    }
}
