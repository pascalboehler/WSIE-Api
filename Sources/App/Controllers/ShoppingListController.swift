//
//  ShoppingListController.swift
//  App
//
//  Created by Pascal Boehler on 05.01.20.
//

import Foundation
import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class ShoppingListController {
    
    /// Returns all recipes owned by user
    func getAllUserListItems(_ req: Request) throws -> Future<[ShoppingListItem]> {
        do {
            let uid = try req.parameters.next(String.self)
            return ShoppingListItem.query(on: req).filter(\.uid, .equal, uid).all()
        } catch {
            throw HTTPError(identifier: "Missing argument", reason: "Please enter UID")
        }
    }
    
    /// Saves a decoded `ShoppingListItem` to the database.
    func create(_ req: Request) throws -> Future<ShoppingListItem> {
        return try req.content.decode(ShoppingListItem.self).flatMap { item in
            return item.save(on: req)
        }
    }

    /// Deletes a parameterized `ShoppingListItem`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(ShoppingListItem.self).flatMap { item in
            return item.delete(on: req)
        }.transform(to: .ok)
    }
}
