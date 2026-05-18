FROM python:3.12-slim

WORKDIR /app

# install dependencies first (layer caching — only rebuilds if requirements change)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy app code
COPY app.py .

# run with gunicorn (production server, not flask dev server)
CMD ["python", "app.py"]
