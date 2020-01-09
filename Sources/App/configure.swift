import FluentSQLite
import FluentMySQL
import Vapor
import DotEnv

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Setup environment variables
    let env = DotEnv(withFile: ".env")
    
    // get DB vars
    let db_hostname = env.get("DB_HOSTNAME") ?? "localhost"
    let db_username = env.get("DB_USERNAME") ?? "user"
    let db_password = env.get("DB_PASSWORD") ?? "secret"
    let db_database = env.get("DB_DATABASE") ?? "database"
    
    // Register providers first
    // try services.register(FluentSQLiteProvider())
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    // let sqlite = try SQLiteDatabase(storage: .file(path: "database.db"))
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    // databases.add(database: sqlite, as: .sqlite)
    
    // Register MySQL Database
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: db_hostname,
        username: db_username,
        password: db_password,
        database: db_database
    )
    
    let mysqlDB = MySQLDatabase(config: mysqlConfig)
    databases.add(database: mysqlDB, as: .mysql)
    
    //Register all Databases
    services.register(databases)
    
    // Configure migrations
    var migrations = MigrationConfig()
    // MySQL
    migrations.add(model: Step.self, database: .mysql)
    migrations.add(model: Ingredient.self, database: .mysql)
    migrations.add(model: Recipe.self, database: .mysql)
    migrations.add(model: ShoppingListItem.self, database: .mysql)
    // SQLite
    /*
    migrations.add(model: Step.self, database: .sqlite)
    migrations.add(model: Ingredient.self, database: .sqlite)
    migrations.add(model: Recipe.self, database: .sqlite)
    */
    services.register(migrations)
}
