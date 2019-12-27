//
//  RecipeController.swift
//  App
//
//  Created by Pascal Boehler on 26.12.19.
//

import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class RecipeController {
    /// Returns a list of all `Todo`s.
    func getAllPublic(_ req: Request) throws -> Future<[Recipe]> {
        return Recipe.query(on: req).filter(\.isPublic, .equal, true).all()
    }
    
    /// Returns all recipes owned by user
    func getAllUserRecipes(_ req: Request) throws -> Future<[Recipe]> {
        do {
            let uid = try req.parameters.next(String.self)
            return Recipe.query(on: req).filter(\.uid, .equal, uid).all()
        } catch {
            throw HTTPError(identifier: "Missing argument", reason: "Please enter UID")
        }
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Recipe> {
        return try req.content.decode(Recipe.self).flatMap { recipe in
            return recipe.save(on: req)
        }
    }

    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Todo.self).flatMap { recipe in
            return recipe.delete(on: req)
        }.transform(to: .ok)
    }
}
