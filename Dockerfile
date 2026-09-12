# Simplest possible approach: no s6-overlay override, just use ENTRYPOINT workaround
FROM nousresearch/hermes-agent:latest

COPY config.yaml /opt/data/config.yaml

USER root
RUN chown hermes:hermes /opt/data/config.yaml && chmod 600 /opt/data/config.yaml
USER hermes

ENV PORT=10000

# Try using wrapper script instead
COPY --chown=hermes:hermes entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
