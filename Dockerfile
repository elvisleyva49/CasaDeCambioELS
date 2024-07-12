# Usa una imagen base de Python
FROM python:3.11-slim

# Instala las dependencias del sistema necesarias para pyodbc
RUN apt-get update && \
    apt-get install -y gcc g++ unixodbc-dev

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos requirements.txt y los instala
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Copia el resto de los archivos de la aplicación al contenedor
COPY . .

# Define el comando para iniciar la aplicación
CMD ["flask", "run", "--host=0.0.0.0"]
