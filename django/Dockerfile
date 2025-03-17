# Use lightweight Python Alpine image
FROM python:3.9.17-alpine

# Environment variables for better performance
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /application

# Set up a virtual environment
ARG VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy and install dependencies separately for better caching
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

RUN chmod -R 755 /application

# Default command 
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]