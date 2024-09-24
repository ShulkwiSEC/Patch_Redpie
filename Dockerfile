# Use a Python base image for linux/amd64
FROM --platform=linux/amd64 ubuntu:20.04

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip curl

# Set the working directory
WORKDIR /app

# Copy all necessary files to the working directory
COPY requirements.txt ./
COPY . ./

# Copy the setup script
COPY setup.sh /app/setup.sh

# Make the setup script executable and run it
RUN chmod +x /app/setup.sh && /app/setup.sh

# Install the required Python packages
RUN python3 -m pip install -r requirements.txt

# Create a new user 'redpie' and set permissions
RUN useradd -m redpie

# Set the environment variable
ENV DEBUG=0

RUN chown -R redpie:redpie /app

# Switch to the new user
USER redpie

# Set the command to run your Flask app
CMD ["python3", "app.py"]