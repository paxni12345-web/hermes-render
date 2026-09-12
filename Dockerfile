# Use the official hermes-agent base image
FROM nousresearch/hermes-agent:latest

# Copy the config.yaml with pre-configured auth
COPY config.yaml /opt/data/config.yaml

# Ensure correct permissions
USER root
RUN chown hermes:hermes /opt/data/config.yaml && chmod 600 /opt/data/config.yaml
USER hermes

# Override the default serve command with dashboard
ENV HERMES_DASHBOARD=1
ENTRYPOINT ["/init"]
CMD ["dashboard", "--host", "0.0.0.0", "--port", "10000"]
