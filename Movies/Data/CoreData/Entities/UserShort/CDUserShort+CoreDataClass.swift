//
//  CDUserShort+CoreDataClass.swift
//  Movies
//
//  Created by Ivan Semenov on 15.11.2023.
//
//

import Foundation
import CoreData

@objc(CDUserShort)
public class CDUserShort: NSManagedObject {

    func toDomain() -> UserShort {
        .init(
            userId: userId,
            nickName: nickname,
            avatar: avatar
        )
    }
}
