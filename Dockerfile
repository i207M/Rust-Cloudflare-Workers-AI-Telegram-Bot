FROM rust:1-alpine

ARG APP_NAME=Rust-Cloudflare-Workers-AI-Telegram-Bot

WORKDIR /app

COPY . .
RUN cargo build --locked --verbose --release
RUN cp ./target/release/$APP_NAME /bin/server

CMD ["/bin/server"]
