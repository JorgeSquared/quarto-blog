FROM ubuntu:24.04

ARG QUARTO_VERSION=1.7.23

# System dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    gdebi-core \
    texlive-full \
    && rm -rf /var/lib/apt/lists/*

# Install Quarto (arm64 build)
RUN curl -LO "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-arm64.deb" \
    && gdebi --non-interactive "quarto-${QUARTO_VERSION}-linux-arm64.deb" \
    && rm "quarto-${QUARTO_VERSION}-linux-arm64.deb"

WORKDIR /project

EXPOSE 4200

ENTRYPOINT ["quarto"]
CMD ["preview", "--host", "0.0.0.0", "--port", "4200"]
