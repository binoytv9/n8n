# Run n8n Repository Walkthrough

I have verified the steps to run the n8n repository locally. Here is what I did and what you need to do.

## Prerequisites

1.  **Node.js**: Version 22.16 or newer (I detected `v24.4.1`).
2.  **pnpm**: Version 10.2 or newer (I verified `v10.22.0`).
    - If needed, enable it with `corepack enable`.

## Steps to Run

1.  **Install Dependencies**:
    ```bash
    pnpm install
    ```

2.  **Build the Project**:
    ```bash
    pnpm build
    ```
    *Note: This may take a few minutes as it builds all packages in the monorepo.*

3.  **Start the Application**:
    You can use the helper script which checks for `.env`:
    ```bash
    ./run.sh
    ```
    Or manually:
    ```bash
    pnpm start
    ```
    This will start the n8n editor at `http://localhost:5678`.

## Exposing via Cloudflare Tunnel

To make your local n8n instance accessible publicly (e.g., for webhooks), you can use `cloudflared`.

### 1. Install and Login
```bash
# Verify installation
cloudflared --version

# Login to Cloudflare
cloudflared login
```

### 2. Create and Route Tunnel
Replace `n8n.binoyy.com` with your desired domain.

```bash
# Create a tunnel named 'n8n'
cloudflared tunnel create n8n

# Route DNS to the tunnel
cloudflared tunnel route dns n8n n8n.binoyy.com
```

### 3. Run Tunnel
```bash
cloudflared tunnel run n8n
```

### 4. Update Configuration
Ensure your `.env` file matches the tunnel domain:
```ini
WEBHOOK_URL=https://n8n.binoyy.com
```

## Development (Optional)

If you are developing and want hot-reloading:

-   **Backend & Frontend**: `pnpm dev`
-   **Backend only**: `pnpm dev:be`
-   **Frontend only**: `pnpm dev:fe`

## Troubleshooting

-   **SQLite Architecture Mismatch**: If you are on an Apple Silicon Mac and see an error about `sqlite3` architecture, run:
    ```bash
    npm_config_target_arch=x64 pnpm rebuild sqlite3
    ```
