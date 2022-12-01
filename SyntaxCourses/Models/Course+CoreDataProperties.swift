//
//  Course+CoreDataProperties.swift
//  SyntaxCourses
//
//  Created by Niclas Borrmann on 30.11.22.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var module: String?
    @NSManaged public var topic: String?

}

extension Course : Identifiable {

}
