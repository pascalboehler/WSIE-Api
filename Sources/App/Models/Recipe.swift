//
//  Recipe.swift
//  App
//
//  Created by Pascal Boehler on 26.12.19.
//

import Foundation
import Vapor
import FluentMySQL
//import FluentSQLite

// final class Recipe: SQLiteModel { // SQLite
final class Recipe: MySQLModel { // MySQL
    var id: Int?
    var title: String
    var timeNeeded: String
    var isFavourite: Bool
    var ingredients: [Ingredient]
    var steps: [Step]
    var shortDescription: String
    var uid: String
    var imageName: String = "NoPhoto"
    var imageData: Data
    var personAmount: Int = 4
    var sharedWith: [String] // for future see kanban for information
    var language: String = "de"
    var isPublic: Bool = false

    enum Category: String, CaseIterable, Codable, Hashable {
        case breakfast = "Breakfast"
        case dinner = "Dinner"
        case lunch = "Lunch"
        case dessert = "Dessert"
        case sweet = "Sweet"
        case savoury = "Savoury"
    }
    
    init(id: Int?, title: String, timeNeeded: String, isFavourite: Bool, ingredients: [Ingredient], steps: [Step], shortDescription: String, uid: String, imageName: String, personAmount: Int, sharedWith: [String], language: String, isPublic: Bool, imageData: Data) {
        self.id = id
        self.title = title
        self.timeNeeded = timeNeeded
        self.isFavourite = isFavourite
        self.ingredients = ingredients
        self.steps = steps
        self.shortDescription = shortDescription
        self.uid = uid
        self.imageName = imageName
        self.personAmount = personAmount
        self.sharedWith = sharedWith
        self.language = language
        self.isPublic = isPublic
        self.imageData = imageData
    }

}

extension Recipe: Migration { }
extension Recipe: Content { }
extension Recipe: Parameter { }
