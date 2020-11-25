FROM dandart/4letters:build as builder
RUN stack install

FROM ubuntu
COPY --from=builder /root/.local/bin/4letters /usr/bin/
CMD ["4letters"]