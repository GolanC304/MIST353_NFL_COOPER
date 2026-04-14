FROM python:3.11-slim

# Install SQL Server drivers
RUN apt-get update && apt-get install -y \
    curl gnupg unixodbc-dev \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18 \
    && apt-get clean

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project (API, UI, Data, etc.)
COPY . .

# Set permissions for the startup script
RUN chmod +x startup.sh

# Azure will provide the $PORT environment variable
EXPOSE 8080

CMD ["./startup.sh"]