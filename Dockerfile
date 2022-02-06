FROM python:3.8.12-bullseye

# Create a user with non root privileges

RUN groupadd --gid 5000 pacman \
    && useradd --home-dir /home/pacman --create-home --uid 5000 \
        --gid 5000 --shell /bin/sh --skel /dev/null pacman


# Make a directory for our application
WORKDIR /home/pacman/app

# Install dependencies 
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt


# Copy our source code 
COPY static ./static
COPY templates ./templates
COPY app.py .


# Set the user created

USER pacman 

# Run the application

CMD [ "python3", "app.py"] 
