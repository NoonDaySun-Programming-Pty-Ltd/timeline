# Timeline

A timeline for personal events

## Docker Setup with FrankenPHP

This project uses FrankenPHP, a modern PHP application server built on top of Caddy, to run a Laravel 12 application.

### Prerequisites

- Docker
- Docker Compose

### Getting Started

1. Clone this repository
2. Build the Docker image:
   ```
   docker build -t timeline .
   ```
3. Run the container:
   ```
   export HTTP_PORT=8080 HTTPS_PORT=444; 
   docker network create timeline; docker compose up -d
   ```
4. Access the application at https://localhost:${HTTPS_PORT}

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
