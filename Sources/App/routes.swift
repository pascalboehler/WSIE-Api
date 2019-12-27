import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    // Recipes:
    let recipeController = RecipeController()
    router.get("recipe", use: recipeController.getAllPublic)
    router.get("recipe/uid", String.parameter, use: recipeController.getAllUserRecipes)
    router.post("recipe", use: recipeController.create)
    router.delete("recipe", Recipe.parameter, use: recipeController.delete)
}
