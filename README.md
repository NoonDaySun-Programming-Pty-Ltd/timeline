# Timeline
A time line for personal events

## Docker Setup with FrankenPHP

This project uses FrankenPHP, a modern PHP application server built on top of Caddy, to run a Laravel 12 application.

### Prerequisites

- Docker
- Docker Compose (optional)

### Getting Started

1. Clone this repository
2. Build the Docker image:
   ```
   docker build -t timeline .
   ```
3. Run the container:
   ```
   docker run -p 80:80 timeline
   ```
4. Access the application at http://localhost

### Development with VS Code

This project includes a devcontainer configuration for VS Code. To use it:

1. Install the "Remote - Containers" extension in VS Code
2. Open the project folder in VS Code
3. Click "Reopen in Container" when prompted
4. VS Code will build the container and open the project inside it

### FrankenPHP Features

- High-performance PHP application server
- Built-in HTTP/2 and HTTP/3 support
- Early Hints support
- Automatic HTTPS
- PHP worker process management

## Database Schema

The application uses a relational database with the following main entities:

- Users - Application users
- Events - Timeline events created by users
- Categories - For categorizing events
- Tags - For tagging events
- Reminders - For event notifications

### ER Diagram

An Entity-Relationship diagram is available in PlantUML format at [docs/er_diagram.puml](docs/er_diagram.puml).

To view the diagram:
1. Use an online PlantUML renderer like [PlantText](https://www.planttext.com/)
2. Use a PlantUML plugin for your IDE (available for VS Code, JetBrains IDEs, etc.)
3. Use the PlantUML command-line tool
