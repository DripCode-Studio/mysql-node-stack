# MySQL Node.js Express Stack

A Docker-based development stack with Node.js, Express.js, and MySQL.

## Structure

```
mysql-node-stack/
├── docker-compose.yaml    # Docker services configuration
├── Dockerfile             # Node.js container definition
├── package.json           # Node.js dependencies
├── init.sql               # Database initialization script
├── utfconf.cnf            # MySQL UTF-8 configuration
├── .env                   # Environment variables
├── root_password          # MySQL root password (secret)
├── database_password      # MySQL database password (secret)
└── src/
    ├── index.js           # Express.js application
    └── connectDatabase.js # MySQL connection utility
```

## Getting Started

1. **Start the stack:**
   ```bash
   docker-compose up --build
   ```

2. **Access the application:**
   - App: http://localhost:8000
   - MySQL: localhost:3309

3. **Stop the stack:**
   ```bash
   docker-compose down
   ```

4. **Stop and remove volumes:**
   ```bash
   docker-compose down -v
   ```

## Development

The `src/` folder is mounted as a volume, so changes will be reflected. For hot-reload during development, you can modify the Dockerfile CMD to use `npm run dev` (uses nodemon).

## Environment Variables

Configure in `.env`:
- `MYSQL_HOST` - MySQL hostname (default: db_1)
- `MYSQL_USER` - MySQL username (default: root)
- `MYSQL_DATABASE` - Database name (default: example)
- `PORT` - Express server port (default: 3000)

## Dependencies

- **express** - Web framework
- **mysql2** - MySQL client with Promise support
- **dotenv** - Environment variable loader
- **winston** - Logging library
- **nodemon** - Development hot-reload (dev dependency)
