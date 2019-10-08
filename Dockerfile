### Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.7.3-stretch

# Set the working directory to /app
WORKDIR /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt ./
COPY gunicorn.py ./
RUN pip install --trusted-host pypi.python.org -r requirements.txt \
    && python3 -O -m compileall -b ./app \
    && find ./app -name "*.py"|xargs rm -rf \
    && python3 -O -m compileall -b ./config.py \
    && rm ./config.py

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["gunicorn", "-c", "gunicorn.py", "run:app"]
