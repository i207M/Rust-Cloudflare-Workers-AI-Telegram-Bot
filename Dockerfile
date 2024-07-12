FROM rust:1-alpine

ARG APP_NAME=Rust-Cloudflare-Workers-AI-Telegram-Bot

WORKDIR /app/build

COPY . .
RUN apk add --no-cache musl-dev openssl openssl-dev pkgconfig
RUN pkg-config --cflags --libs openssl
RUN cargo build --locked --verbose --release
RUN cp /app/build/target/release/$APP_NAME /app/server

CMD ["/app/server"]
