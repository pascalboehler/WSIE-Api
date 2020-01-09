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
    
    // Recipes:
    let recipeController = RecipeController()
    router.get("recipe", use: recipeController.getAllPublic)
    router.get("recipe/uid", String.parameter, use: recipeController.getAllUserRecipes)
    router.post("recipe", use: recipeController.create)
    router.delete("recipe", use: recipeController.delete)
    
    // ShoppingList:
    let shoppingListItemController = ShoppingListController()
    router.get("shoppingList/uid", String.parameter, use: shoppingListItemController.getAllUserListItems)
    router.post("shoppingList", use: shoppingListItemController.create)
    router.delete("shoppingList", use: shoppingListItemController.delete)
}
