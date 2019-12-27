import FluentSQLite
import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
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
        hostname: Environment.get("DB_HOSTNAME")!,
        username: Environment.get("DB_USERNAME")!,
        password: Environment.get("DB_PASSWORD")!,
        database: Environment.get("DB_DATABASE")!
    )
    
    let mysqlDB = MySQLDatabase(config: mysqlConfig)
    databases.add(database: mysqlDB, as: .mysql)
    
    //Register all Databases
    services.register(databases)
    
    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: Step.self, database: .mysql)
    migrations.add(model: Ingredient.self, database: .mysql)
    migrations.add(model: Recipe.self, database: .mysql)
    services.register(migrations)
}
