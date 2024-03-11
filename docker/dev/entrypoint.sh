#!/bin/bash
# entrypoint.sh

# Install gem dependencies
bundle install

# Install node packages
npm install

# Pre-Compile Assets
rails assets:precompile

# Migrate database
rails db:create db:migrate db:seed

# Add minio alias
mc alias set minio $S3_ENDPOINT $S3_ACCESS_KEY $S3_SECRET_KEY

# Check if the bucket exists
if mc ls minio | grep -q "$S3_BUCKET"; then
  echo "Bucket already exists"
else
  # Create the bucket
  mc mb "minio/$S3_BUCKET"
  mc anonymous set download "minio/$S3_BUCKET"
  echo "Bucket created successfully"
fi

# Remove servier .pid file
rm tmp/pids/server.pid

# Start rails server
rails s -b 0.0.0.0

# Start a bash console
/bin/bash
