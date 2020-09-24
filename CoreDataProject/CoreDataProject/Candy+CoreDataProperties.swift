//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by George Solorio on 9/15/20.
//  Copyright © 2020 George Solorio. All rights reserved.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
   
   public var wrappedName: String {
      name ?? "Unkown Candy"
   }

}
