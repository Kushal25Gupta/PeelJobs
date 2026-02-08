FROM python:3.11-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

COPY requirements.txt requirements.txt

# RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

RUN cp .env.dev.sample .env

RUN apt-get update && apt-get install -y \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf-2.0-0 \
    libffi-dev \
    shared-mime-info \
    fonts-dejavu \
    && rm -rf /var/lib/apt/lists/*


#EXPOSE 8000

RUN chmod +x entrypoint.sh

ENV APP_HOME=/app
ENV DEBUG=1
RUN mkdir $APP_HOME/staticfiles
RUN mkdir $APP_HOME/mediafiles

CMD ["sh", "entrypoint.sh"]
