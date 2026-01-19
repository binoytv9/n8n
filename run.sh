#!/bin/bash

# Check if .env file exists
if [ -f .env ]; then
  echo "Loading Environment Variables from .env..."
  # Use set -a to export variables defined in .env
  set -a
  source .env
  set +a
else
  echo ".env file not found, running without pre-loaded environment variables."
fi

# Run the project
echo "Starting n8n..."
pnpm start
