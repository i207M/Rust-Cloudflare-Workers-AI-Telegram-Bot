# Stage 1: Build the Rust binary
FROM rust:1-bullseye AS build

# Set a working directory
WORKDIR /app

# Copy the source code
COPY . .

# Build the application
RUN rustup target add x86_64-alpine-linux-musl
RUN cargo build --locked --verbose --release --target x86_64-alpine-linux-musl

# Stage 2: Create a minimal runtime image
FROM alpine:latest

ARG APP_NAME=Rust-Cloudflare-Workers-AI-Telegram-Bot
WORKDIR /app

RUN apk --no-cache add ca-certificates

COPY --from=build /app/target/release/$APP_NAME /app/server

# Set the startup command
CMD ["/app/server"]
