FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Install git
RUN apt-get update && apt-get install -y git

#update pip
RUN python -m pip install --upgrade pip 

# Create a non-root user and grant permissions to the /app folder
RUN useradd -m -u 1001 -r -s /bin/false fastchat && chown -R fastchat /app

# Change to the non-root user
USER 1001

# Install FastChat
RUN pip3 install --no-cache-dir fschat

# Install the latest main branch of huggingface/transformers
RUN pip3 install --no-cache-dir git+https://github.com/huggingface/transformers

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define environment variable
ENV NAME fastchat

# Run app.py when the container launches
CMD ["python3", " -m fastchat.serve.gradio_web_server"]