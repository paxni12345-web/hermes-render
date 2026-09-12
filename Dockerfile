# Use the official hermes-agent base image
FROM nousresearch/hermes-agent:latest

# Copy the config.yaml with pre-configured auth
COPY config.yaml /opt/data/config.yaml

# Ensure correct permissions
USER root
RUN chown hermes:hermes /opt/data/config.yaml && chmod 600 /opt/data/config.yaml
USER hermes

# Set environment to force dashboard mode
ENV HERMES_DASHBOARD=1
ENV PORT=10000

# Use shell form to let s6-overlay handle the command properly
CMD hermes dashboard --host 0.0.0.0 --port 10000
