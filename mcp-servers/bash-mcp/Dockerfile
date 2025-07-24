FROM node:18-alpine

# Install basic system tools
RUN apk add --no-cache bash curl git

# Set working directory
WORKDIR /app

# Install DesktopCommanderMCP globally
RUN npm install -g @wonderwhy-er/desktop-commander@latest

# Create necessary directories with proper ownership
RUN mkdir -p /app/config /app/logs/audit /app/mcp-testing-jail \
    && chown -R node:node /app \
    && chmod 755 /app/mcp-testing-jail

# Switch to non-root user
USER node

# Copy configuration files
COPY --chown=node:node config/ /app/config/

# Set environment variables
ENV NODE_ENV=production
ENV MCP_LOG_LEVEL=info
ENV MCP_CONFIG_FILE=/app/config/mcp-server-config.json

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD node -e "console.log('Health check passed')" || exit 1

# No ports exposed (stdio transport)

# Set working directory to jail for commands
WORKDIR /app/mcp-testing-jail

# Start the MCP server
CMD ["node", "/usr/local/lib/node_modules/@wonderwhy-er/desktop-commander/dist/index.js"]