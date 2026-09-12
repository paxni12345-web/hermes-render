# Use base image ENTRYPOINT — don't override
FROM nousresearch/hermes-agent:latest

# Copy config and fix ownership
COPY config.yaml /opt/data/config.yaml
USER root
RUN chown hermes:hermes /opt/data/config.yaml && chmod 600 /opt/data/config.yaml
USER hermes

# Dashboard mode env vars
ENV HERMES_DASHBOARD=1
ENV HERMES_DASHBOARD_HOST=0.0.0.0
ENV HERMES_DASHBOARD_PORT=10000
ENV HERMES_DASHBOARD_TUI=1
ENV PORT=10000

# Use base image ENTRYPOINT, just override CMD
CMD ["dashboard", "run"]
