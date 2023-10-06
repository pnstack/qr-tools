start:
	uvicorn server:app --reload --host 0.0.0.0 --port 5001
build:
	docker build -t ocr-service .
start-docker:
	docker run -it --rm -p 5001:5001 --name ocr-service ocr-service
requirements:
	pip3 freeze > requirements.txt

