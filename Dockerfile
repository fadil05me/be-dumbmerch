FROM golang:1.18-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod tidy

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o backend .

FROM alpine:3.18

WORKDIR /app

COPY --from=build /app/backend .

COPY .env .env

RUN apk --no-cache add ca-certificates tzdata

EXPOSE 5000

ENTRYPOINT ["/app/backend"]
