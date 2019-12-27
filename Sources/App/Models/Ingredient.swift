//
//  Ingredient.swift
//  App
//
//  Created by Pascal Boehler on 26.12.19.
//

import Foundation
import Vapor
import FluentSQLite

final class Ingredient: SQLiteModel {
    var id: Int?
    var name: String
    var amount: String
    
    init (id: Int? = nil, name: String, amount: String) {
        self.id = id
        self.name = name
        self.amount = amount
    }
}

extension Ingredient: Migration { }
extension Ingredient: Content { }
extension Ingredient: Parameter { }
