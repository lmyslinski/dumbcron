# Build stage
FROM rust:latest as builder
WORKDIR /app
ADD . /app
RUN cargo build --release

# Prod stage
FROM gcr.io/distroless/cc
COPY --from=builder /app/target/release/dumbcron /
CMD ["./dumbcron"]