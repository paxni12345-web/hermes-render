# Use the official hermes-agent base image
FROM nousresearch/hermes-agent:latest

# Copy the config.yaml with pre-configured auth
COPY config.yaml /opt/data/config.yaml

# Ensure correct permissions
USER root
RUN chown hermes:hermes /opt/data/config.yaml && chmod 600 /opt/data/config.yaml

# Create s6-overlay service override to run dashboard instead of serve
RUN mkdir -p /etc/s6-overlay/s6-rc.d/user/contents.d/hermes-dashboard && \
    echo '#!/command/execlineb -P' > /etc/s6-overlay/s6-rc.d/user/contents.d/hermes-dashboard/run && \
    echo 's6-setuidgid hermes' >> /etc/s6-overlay/s6-rc.d/user/contents.d/hermes-dashboard/run && \
    echo 'hermes dashboard --host 0.0.0.0 --port 10000' >> /etc/s6-overlay/s6-rc.d/user/contents.d/hermes-dashboard/run && \
    chmod +x /etc/s6-overlay/s6-rc.d/user/contents.d/hermes-dashboard/run

USER hermes

# Set environment
ENV HERMES_DASHBOARD=1
ENV PORT=10000
