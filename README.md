# Weather Forecasts App

## Overview

This Rails application is designed as an API-only service, focused on providing weather forecasts for various cities. It utilizes the OpenWeather API to gather weather data for the next seven days. The application exposes a single controller, `forecasts_controller`, which can be accessed through the route `api/v1/forecasts`.

## Requirements

- Ruby version: 3.1.0
- Rails version: 7.0.8
- Docker

## Setup
1. Clone the repository to your local machine.
2. Create an `.env` file in the root directory and save your OpenWeather API key with the variable name `OW_API_KEY`.

/.env
```bash
OW_API_KEY = "YOUR_KEY_HERE"
```

## Running with Docker
1. Build the Docker image:
   ```
   docker-compose build
   ```

2. Start the Rails application within the Docker container:
   ```
   docker-compose run --service-ports web bash
   ```

3. Inside the Docker container, run the following command to start the Rails application:
   ```
   rails s -b 0.0.0.0
   ```

4. Access the API at `localhost:3000/api/v1/forecasts?q=your_query`, replacing `your_query` with the desired city.

## API Endpoint
- **GET /api/v1/forecasts**
  - Query Parameter: `q` (city query)
  - Example: `localhost:3000/api/v1/forecasts?q=Veracruz` or `localhost:3000/api/v1/forecasts?q=Ver`

## Note
Ensure that you have a valid and active OpenWeather API key stored in the `.env` file for the application to fetch weather data successfully.