# Use the official Python slim image as a base
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libcairo2-dev \
    libfreetype6-dev \
    libffi-dev \
    libjpeg-dev \
    libpng-dev \
    libz-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy your MkDocs project requirements
COPY requirements-doc.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements-doc.txt

# Copy any build scripts (optional)
COPY build_mkdocs.sh .
RUN chmod +x build_mkdocs.sh

# Set the default work directory for MkDocs
WORKDIR /docs

# Expose the default MkDocs dev-server port
EXPOSE 8000

# Default command: start the MkDocs dev server with live reload
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8000", "--livereload"]
