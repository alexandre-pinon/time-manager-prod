# Extend from the official Elixir image
FROM elixir:latest

RUN apt-get update && \ 
    apt-get install -y postgresql-client

# Create app directory and copy the Elixir projects into it
RUN mkdir /app

WORKDIR /app

COPY . .

# Install hex package manager
# By using --force, we don’t need to type “Y” to confirm the installation
RUN mix local.hex --force && mix local.rebar --force

# Install dependencies and compile to speed up the container creation
RUN mix deps.get && mix do compile

RUN chmod +x entrypoint.sh

EXPOSE 4000

CMD ["/app/entrypoint.sh" ]
