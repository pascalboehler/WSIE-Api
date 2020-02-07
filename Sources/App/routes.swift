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
    
    let routePrefix = "api/v1/"
    
    // Recipes:
    let recipeController = RecipeController()
    router.get("\(routePrefix)recipe", use: recipeController.getAllPublic)
    router.get("\(routePrefix)recipe/uid", String.parameter, use: recipeController.getAllUserRecipes)
    router.post("\(routePrefix)recipe", use: recipeController.create)
    router.delete("\(routePrefix)recipe", use: recipeController.delete)
    
    // ShoppingList:
    let shoppingListItemController = ShoppingListController()
    router.get("\(routePrefix)shoppingList/uid", String.parameter, use: shoppingListItemController.getAllUserListItems)
    router.post("\(routePrefix)shoppingList", use: shoppingListItemController.create)
    router.delete("\(routePrefix)shoppingList", use: shoppingListItemController.delete)
}
