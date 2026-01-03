# Stage 1: récupérer le binaire officiel
FROM prom/alertmanager:v0.27.0 AS upstream

# Stage 2: image finale Alpine (on a apk + envsubst)
FROM alpine:3.20

RUN apk add --no-cache gettext ca-certificates

# binaire alertmanager (go statique) + outil amtool (optionnel)
COPY --from=upstream /bin/alertmanager /bin/alertmanager
COPY --from=upstream /bin/amtool /bin/amtool

# template + entrypoint
COPY alertmanager.yml.tpl /etc/alertmanager/alertmanager.yml.tpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9093
ENTRYPOINT ["/entrypoint.sh"]
