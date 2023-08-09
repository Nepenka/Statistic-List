//
//  User.swift
//  StatsList
//
//  Created by 123 on 11.07.23.
//

import Foundation
import CoreData


class UserProfile: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var lastName: String
    @NSManaged var login: String
    @NSManaged var password: String
}
