# create base image

FROM python:3.10-slim as base

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

RUN pip install pipenv
RUN apt-get update 
RUN apt-get install -y --no-install-recommends gcc
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get install zbar-tools -y
RUN apt-get install libzbar-dev -y


FROM base AS python-deps

# Install python dependencies in /.venv
COPY Pipfile .
COPY Pipfile.lock .
RUN PIPENV_VENV_IN_PROJECT=1 pipenv install --deploy

# download model and run test
COPY demo.png .
COPY download.py .

ENV PATH="/.venv/bin:$PATH"
RUN python download.py

FROM base AS runtime
# Copy virtual env from python-deps stage
COPY --from=python-deps /.venv /.venv
ENV PATH="/.venv/bin:$PATH"

# Create and switch to a new user
RUN useradd --create-home appuser
WORKDIR /home/appuser
USER appuser

COPY . .

# Run the application
EXPOSE 5001
CMD ["uvicorn", "server:app", "--host", "0.0.0.0", "--port", "5001"]