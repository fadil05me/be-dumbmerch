FROM golang:1.16-alpine as build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download
COPY . .

RUN go build -o go-docker

FROM alpine:latest

WORKDIR /app

COPY --from=build /app/go-docker .
COPY .env .env

EXPOSE 5000

CMD ["./go-docker"]
