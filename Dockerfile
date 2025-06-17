FROM python:3.11-slim

WORKDIR /app

RUN apt-get update
RUN apt-get install -y wget python3 python3-pip python3-venv nginx sqlite3

COPY . .

RUN python3 -m venv venv

RUN pip install --no-cache-dir -r requirements.txt --break-system-packages
RUN wget https://megavul.vsim.xyz/megavul_simple.json

RUN python3 ./conf/converter_db.py

RUN export FLASK_SECRET_KEY=$(python -c "import secrets; print(secrets.token_hex(32))")

CMD ["python", "app.py"]
