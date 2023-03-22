FROM debian:bullseye-slim
LABEL maintainer="rick@dockergiant.com"

# Installs latest Chromium package.
RUN apt-get update \
	&& apt-get install -y chromium chromium-swiftshader ttf-freefont font-noto-emoji font-wqy-zenhei \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY local.conf /etc/fonts/local.conf

# Add Chrome as a user
RUN mkdir -p /var/www/html \
    && adduser -D chrome \
    && chown -R chrome:chrome /var/www/html
# Run Chrome as non-privileged
USER chrome
WORKDIR /var/www/html

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/

# Autorun chrome headless
ENV CHROMIUM_FLAGS="--disable-software-rasterizer --disable-dev-shm-usage"
ENTRYPOINT ["chromium-browser", "--headless"]
