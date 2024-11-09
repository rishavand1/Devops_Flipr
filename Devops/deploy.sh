#!/bin/bash

# Variables for versioning
FRONTEND_IMAGE="ddevopsf/frontend"
BACKEND_IMAGE="ddevopsb/backend"
VERSION="v1.0"

# Step 1: Build Docker images for frontend and backend
echo "Building frontend and backend Docker images..."
docker build -t $FRONTEND_IMAGE:$VERSION ./frontend
docker build -t $BACKEND_IMAGE:$VERSION ./backend

# Step 2: Tag images
echo "Tagging Docker images..."
docker tag $FRONTEND_IMAGE:$VERSION $FRONTEND_IMAGE:latest
docker tag $BACKEND_IMAGE:$VERSION $BACKEND_IMAGE:latest

# Step 3: Push images to Docker Hub
echo "Pushing images to Docker Hub..."
docker push $FRONTEND_IMAGE:$VERSION
docker push $BACKEND_IMAGE:$VERSION

# Step 4: Update the Docker Compose file with new image versions
echo "Updating Docker Compose file..."
sed -i "s|\(^\s*image: \).*|\1$FRONTEND_IMAGE:$VERSION|" docker-compose.yml
sed -i "s|\(^\s*image: \).*|\1$BACKEND_IMAGE:$VERSION|" docker-compose.yml

# Step 5: Run Docker Compose to start the application
echo "Starting the application using Docker Compose..."
docker-compose up -d
