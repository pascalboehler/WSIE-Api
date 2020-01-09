//
//  ShoppingList.swift
//  App
//
//  Created by Pascal Boehler on 05.01.20.
//

import Foundation
import Vapor
import FluentMySQL

struct ShoppingListItem: MySQLModel {
    var id: Int?
    var itemTitle: String
    var itemAmount: Int
    var itemUnit: String
    var isCompleted: Bool = false
    var uid: String
}

extension ShoppingListItem: Migration {
    static func prepare(on connection: MySQLConnection) -> EventLoopFuture<Void> {
        return MySQLDatabase.update(ShoppingListItem.self, on: connection) { builder in
            builder.field(for: \.itemUnit)
            builder.field(for: \.itemAmount)
        }
    }
}
extension ShoppingListItem: Parameter { }
extension ShoppingListItem: Content { }
