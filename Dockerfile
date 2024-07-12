# Stage 1: Build the Rust binary
FROM rust:1-bullseye AS build

# Set a working directory
ARG APP_NAME=Rust-Cloudflare-Workers-AI-Telegram-Bot
WORKDIR /app

# Copy the source code
COPY . .

# Build the application
RUN cargo build --verbose --release

# Stage 2: Create a minimal runtime image
FROM debian:bullseye-slim

WORKDIR /app

COPY --from=build /app/target/release/$APP_NAME /app/server

# Set the startup command
CMD ["/app/server"]
