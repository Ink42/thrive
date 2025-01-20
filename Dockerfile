# Use an official Flutter Docker image
FROM cirrusci/flutter

# Set the working directory
WORKDIR /app

# Copy project files into the container
COPY . .

# Install Flutter dependencies
RUN flutter pub get

# Run Flutter tests (can be run during the build or as a separate GitHub Actions step)
CMD ["flutter", "test"]
