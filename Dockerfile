FROM fpco/stack-build as builder
COPY . .
RUN stack install

FROM ubuntu
COPY --from=builder /root/.local/bin/4letters /usr/bin/
CMD ["4letters"]