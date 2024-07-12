# Usa una imagen base de Python 3.10
FROM python:3.10-slim

# Instala las dependencias del sistema necesarias para pyodbc
RUN apt-get update && \
    apt-get install -y gcc g++ unixodbc-dev curl

# Descarga e instala el ODBC Driver 17 para SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos requirements.txt y los instala
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copia el resto de los archivos de la aplicación al contenedor
COPY . .

# Define el comando para iniciar la aplicación
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
