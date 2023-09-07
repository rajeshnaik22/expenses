# Use the official Ruby image as a base image
FROM ruby:2.7.3

# Install any additional dependencies you need for your project
RUN apt-get update && \
    apt-get install -y \
    # Add your dependencies here

# Set the working directory in the container
WORKDIR /app

# Copy your project files into the container
COPY . .

# Expose any necessary ports
 EXPOSE 3000

# You can customize this part based on your project's setup
# For example, you might want to run a specific command here
# CMD ["rails", "server"]
