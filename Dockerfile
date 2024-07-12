# Stage 1: Build the Rust binary
FROM rust:1-alpine AS build

# Set a working directory
ARG APP_NAME=Rust-Cloudflare-Workers-AI-Telegram-Bot
WORKDIR /app

# Copy the source code
COPY . .

# Build the application
RUN apk add --no-cache musl-dev pkgconfig
RUN RUST_BACKTRACE=1 cargo build --verbose --release

# Stage 2: Create a minimal runtime image
FROM alpine:latest

WORKDIR /app

RUN apk --no-cache add ca-certificates

COPY --from=build /app/target/release/$APP_NAME /app/server

# Set the startup command
CMD ["/app/server"]
