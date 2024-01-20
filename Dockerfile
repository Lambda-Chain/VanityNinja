# Use a imagem oficial do Python 3.11.4
FROM python:3.11.4

# Defina o diretório de trabalho no contêiner
WORKDIR /app

# Copie os arquivos necessários para o aplicativo
COPY api.py /app/api.py
COPY requirements.txt /app/requirements.txt

# Instale as dependências usando o pip
RUN pip install -r requirements.txt

# Baixe e descompacte o ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip

# Defina o seu authtoken do ngrok como uma variável de ambiente
ENV NGROK_AUTHTOKEN=2bBgZKtmIiH2wuW6uPJWA578Fkk_6feRukpaqWSw7UsEnd8DB

# Execute o ngrok em segundo plano, apontando para a porta 8000
RUN ./ngrok http 8000 &

# Defina a porta a ser usada pelo aplicativo
ENV PORT=8000

# Exponha a porta 8000 do aplicativo e a porta 4040 do ngrok
EXPOSE 8000 4040

# Comando para executar o aplicativo
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]