# Stage 1: Build Stage
FROM python:3.9-slim AS build

WORKDIR /app

COPY . .
RUN pip install --no-cache-dir -r requirements.txt --force-reinstall

# Stage 2: Production Stage
FROM python:3.9-alpine

COPY --from=build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=build /app /app

# Set environment variables to prevent Python from writing .pyc files and to flush output
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

WORKDIR /app

EXPOSE 5000

CMD ["python", "app.py"]
