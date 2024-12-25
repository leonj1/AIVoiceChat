# Docker image name and tag
IMAGE_NAME = voice-talk
TAG = latest
PORT ?= 6868# Default port, can be overridden from command line

# Full image name
FULL_IMAGE = $(IMAGE_NAME):$(TAG)

# Container name
CONTAINER_NAME = voice-talk-container

.PHONY: build run stop

# Build the Docker image
build:
	docker build -t $(FULL_IMAGE) .

# Run the container
# Using --rm to automatically remove the container when it exits
run:
	docker run --name $(CONTAINER_NAME) \
		-d \
		-p $(PORT):8000 \
		-e OPENAI_API_KEY=${OPENAI_API_KEY} \
		-e ELEVENLABS_API_KEY=${ELEVENLABS_API_KEY} \
		$(FULL_IMAGE)

# Stop the running container
stop:
	docker stop -t 0 $(CONTAINER_NAME) || true
	docker rm -f $(CONTAINER_NAME) || true

# Clean up any stopped containers and unused images
clean: stop
	docker system prune -f
