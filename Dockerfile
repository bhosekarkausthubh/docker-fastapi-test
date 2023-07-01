FROM python:3.9
WORKDIR /app
COPY requirements.txt .
COPY test .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8000
CMD ["uvicorn", "main:app", "--reload"]
