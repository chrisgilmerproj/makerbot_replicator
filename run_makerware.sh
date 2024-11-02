#!/bin/bash

# Check if xauth is installed on the host system
if ! command -v xauth &> /dev/null; then
    echo "xauth is not installed. Installing it..."
    sudo apt-get update && sudo apt-get install -y xauth
else
    echo "xauth is already installed."
fi

# Allow Docker containers to connect to your X11 display
xhost +local:root

# Check if an Xauthority file exists
XAUTHORITY_FILE=~/.Xauthority

if [ ! -f "$XAUTHORITY_FILE" ]; then
    echo "Creating a new Xauthority file..."
    touch "$XAUTHORITY_FILE"
fi

# Share X11 authentication with the Docker container
xauth nlist "$DISPLAY" | sed -e 's/^..../ffff/' | xauth -f "$XAUTHORITY_FILE" nmerge -

# Run the Docker Compose setup
docker-compose up -d

# Optional: Add commands for additional container interaction (e.g., to access the container or logs)
echo "Makerware container is running. You can access the logs using:"
echo "  docker-compose logs -f makerware"
echo "Or enter the container interactively using:"
echo "  docker-compose exec makerware bash"

# Check if the USB device is available
if [ -c /dev/ttyUSB0 ]; then
    echo "3D printer USB device detected at /dev/ttyUSB0."
else
    echo "3D printer USB device not found. Please check your connection."
fi
