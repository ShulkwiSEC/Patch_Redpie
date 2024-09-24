# Use a Python base image for linux/amd64
FROM --platform=linux/amd64 ubuntu:20.04

# Copy flag
COPY flag.txt /root/

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip curl

# Set the working directory
WORKDIR /app

# Copy all necessary files to the working directory
COPY app.py ./
COPY README.md ./
COPY requirements.txt ./
COPY setup.sh ./
COPY templates ./templates/
COPY RedPie ./RedPie/

# Copy the setup script
COPY setup.sh .

# Make the setup script executable and run it
RUN chmod +x setup.sh
RUN ["bash","./setup.sh"]

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