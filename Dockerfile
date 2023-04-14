FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Copy requirements.txt into the container at /app
COPY requirements.txt /app/

# Install any needed packages specified in requirements.txt
RUN pip3 install --trusted-host pypi.python.org -r requirements.txt

# Install FastChat
RUN pip3 install fschat

# Install the latest main branch of huggingface/transformers
RUN pip3 install git+https://github.com/huggingface/transformers

# Create a non-root user and grant permissions to the /app folder
RUN useradd -m -u 1001 -r -s /bin/false appuser && chown -R appuser /app

# Change to the non-root user
USER 1001

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python3", " -m fastchat.serve.gradio_web_server"]