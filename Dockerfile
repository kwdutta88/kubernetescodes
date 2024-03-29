# Use the official Python 3.8 image as the base image
FROM python:3.8-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file to the working directory
COPY requirements.txt requirements.txt

# Install the dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Copy the entire current directory into the container at /app
COPY . .

# Expose the port that your Flask app will run on
EXPOSE 5000

# Specify the command to run on container start
CMD [ "python3", "-m", "flask", "run", "--host=0.0.0.0", "--port=5000" ]
