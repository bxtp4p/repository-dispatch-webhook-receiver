FROM almir/webhook
RUN apk add --no-cache bash curl ca-certificates

CMD ["-verbose", "-hooks=/etc/webhook/hooks.json", "-hotreload", "-template"]