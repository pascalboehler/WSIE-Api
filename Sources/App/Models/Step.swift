//
//  Step.swift
//  App
//
//  Created by Pascal Boehler on 26.12.19.
//

import Foundation
import Vapor
import FluentMySQL
//import FluentSQLite

//final class Step: SQLiteModel { // SQLite
final class Step: MySQLModel { // MySQL
    var id: Int?
    var description: String
    var image: String // change later to image + if none no image is set
    init(id: Int?, description: String, image: String) {
        self.id = id
        self.description = description
        self.image = image
    }
}

extension Step: Migration { }
extension Step: Parameter { }
extension Step: Content { }
