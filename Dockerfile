FROM golang:1.23-alpine AS builder

RUN apk add --no-cache git
WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN go build -o main .


FROM scratch
COPY --from=builder /app/main .

CMD ["./main"]