# Multi-Tier Book Catalogue System

A two-service Spring Boot application for managing books, consisting of a web UI service and a management API service.

## System Architecture

- **Web UI Service (Port 8080)**: Frontend service handling user interface and interactions
- **Management Service (Port 8081)**: Backend service with REST API and database operations
- **Database**: H2 in-memory database (managed by Management Service)

## Prerequisites

- Java 8 or higher
- Maven 3.6 or higher
- Available ports: 8080 and 8081

## Project Structure

- **web_ui**: Frontend service with JSP views and controller logic
- **management_api**: Backend service with REST API and database operations

### Docker-Specific Issues

1. Container Startup

   - Check container logs: `docker-compose logs`
   - Verify Docker daemon is running
   - Ensure sufficient system resources

2. Volume Persistence
   - Check volume mounting: `docker volume ls`
   - Verify data persistence across restarts

## Quick Start

1. Clone the repository:
   git clone [repository-url]
   cd multi-tier-catalogue

2. Start the Management Service (Backend):
   cd mgmt_ui
   ./mvnw clean package
   java -jar target/mgmt_ui-0.0.1-SNAPSHOT.jar

3. Start the Web UI Service (Frontend):
   cd web_ui
   ./mvnw clean package
   java -jar target/web_ui-0.0.1-SNAPSHOT.jar

4. Access the application:
   - Web UI: http://localhost:8080/books

- Management API: http://localhost:8081/api/books

## API Endpoints (Management Service)

| Method | Endpoint          | Description    |
| ------ | ----------------- | -------------- |
| GET    | /api/books        | List all books |
| POST   | /api/books        | Add a new book |
| PUT    | /api/books/{isbn} | Update a book  |
| DELETE | /api/books/{isbn} | Delete a book  |

### Sample Book JSON Structure

json
{
"name": "Sample Book",
"isbn": "123-456-789",
"publishDate": "07/01/2025",
"bookType": "Hard Cover",
"price": 299.99
}

## Features

### Web UI Service

- List all books with sorting and filtering
- Add new books with validation
- Edit existing books
- Delete books with confirmation
- Responsive web interface

### Management Service

- RESTful API with CRUD operations
- In-memory H2 database
- Data validation
- Error handling

## Technical Stack

### Web UI Service

- Spring Boot 2
- JSP/JavaScript
- Bootstrap for styling
- JAX-RS Client for API integration
- Maven for build management

### Management Service

- Spring Boot 2
- H2 Database
- Spring Data JPA
- RESTful API
- Maven for build management

## Development

### Building the Projects

Build Management Service:
bash:README.md
cd mgmt_ui
mvn clean package

Build Web UI Service:

bash:README.md
cd web_ui
mvn clean package

### Running Tests

```bash
mvn test
```

## Configuration

#### Web UI Service (application.properties)

```properties
server.port=8080
backend.api.url=http://localhost:8081/api/books
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

#### Management Service (application.properties)

```properties
server.port=8081
spring.h2.console.enabled=true
spring.datasource.url=jdbc:h2:mem:bookdb
```

## Troubleshooting

1. **Services Won't Start**

   - Verify ports 8080 and 8081 are available
   - Ensure Java 8 or higher is installed
   - Check application logs for errors

2. **Cannot Add/Edit Books**

   - Verify both services are running
   - Check browser console for JavaScript errors
   - Verify API endpoint connectivity

3. **Database Issues**

   - Access H2 console at http://localhost:8081/h2-console
   - Verify database connection properties

4. **Service Communication**
   - Verify both services are running
   - Check network connectivity between services
   - Confirm correct API endpoint URLs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Environment Configuration

Each service uses environment variables for configuration. To set up:

1. Copy the template files to create your environment files:

   ```bash
   # For Web UI Service
   cp web_ui/.env.template web_ui/.env

   # For Management Service
   cp mgmt_ui/.env.template mgmt_ui/.env
   ```

2. Modify the `.env` files with your specific configuration:

   **Web UI Service (.env)**:

   ```properties
   SERVER_PORT=8080
   BACKEND_API_URL=http://localhost:8081/api/books
   ```

   **Management Service (.env)**:

   ```properties
   SERVER_PORT=8081
   DB_URL=jdbc:h2:file:./data/books
   DB_USERNAME=sa
   DB_PASSWORD=your_secure_password
   ALLOWED_ORIGINS=http://localhost:8080
   ```

Note: The `.env` files are not committed to version control for security reasons. Make sure to set up these files when deploying the application.
