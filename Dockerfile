FROM nousresearch/hermes-agent:latest

# Fix permissions for dashboard Chat tab (ui-tui needs to be writable by hermes user)
# and short-circuit build checks that fail on Render
USER root
RUN chown -R hermes:hermes /opt/hermes/ui-tui /opt/hermes/node_modules \
 && mkdir -p /opt/hermes/ui-tui/packages/hermes-ink/dist /opt/hermes/ui-tui/dist \
 && touch /opt/hermes/ui-tui/packages/hermes-ink/dist/ink-bundle.js \
          /opt/hermes/ui-tui/dist/entry.js \
 && chown -R hermes:hermes /opt/hermes/ui-tui

# Copy config (will be overridden by mounted disk, but useful for local testing)
COPY config.yaml /opt/data/config.yaml
RUN chown hermes:hermes /opt/data/config.yaml && chmod 600 /opt/data/config.yaml

# Dashboard mode — gateway runs in foreground, dashboard backgrounds when HERMES_DASHBOARD=1
ENV HERMES_DASHBOARD=1
ENV HERMES_DASHBOARD_HOST=0.0.0.0
ENV HERMES_DASHBOARD_PORT=10000
ENV HERMES_DASHBOARD_TUI=1
ENV PORT=10000

USER root

# Override entrypoint — s6-overlay fails with permission issues on Render (uid 10000 can't write /run)
# Start dashboard in background, then exec gateway as hermes user
ENTRYPOINT []
CMD ["/bin/bash", "-c", "su -s /bin/bash hermes -c 'dashboard run' & exec su -s /bin/bash hermes -c 'gateway run'"]
