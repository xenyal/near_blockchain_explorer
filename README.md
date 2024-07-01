# Blockchain Explorer

This is a blockchain explorer application designed to fetch and display transactions from the NEAR blockchain. The application is built using Ruby on Rails for the backend and React for the frontend, with Tailwind CSS for styling.

## Features

- **Root Index Page**: Displays a list of transfer transactions with the following fields: sender, receiver, and deposit.
- **Average Gas Burnt**: A section on the page shows the average gas burnt for all transactions.
- **Historical Transactions**: The app retains and displays historical transactions it has already fetched, even if they are no longer returned by the remote NEAR API.
- **Extensibility**: While currently only using NEAR, the app is modeled to accommodate additional blockchain networks in the future.

## Installation

### Prerequisites

- Ruby (>= 2.7.0)
- Node.js (>= 18.0)
- PostgreSQL
- Redis (for Sidekiq)

### Setup

1. **Clone the repository**:

    ```sh
    git clone https://github.com/xenyal/near_blockchain_explorer/
    cd near_blockchain_explorer
    ```

2. **Install dependencies**:

    ```sh
    bundle install
    npm install
    ```

3. **Set up the database**:

    ```sh
    rails db:setup
    ```

4. **Configure environment variables**:

    Create a `.env` file in the root directory, using the provided template:

    ```sh
    mv .env.example .env
    ```

5. **Run the application**:

    We utilize the Rails 7 bin/dev script in conjunction with a Procfile to start a minimal local environment.
    Presently, processes are spun up for Rails, Sidekiq, and Node in watchmode

    ```sh
    bin/dev
    ```

## Usage

- Navigate to `http://localhost:3000` to view the root index page.
- This page displays a list of transfer transactions with the sender, receiver, and deposit fields.
- The average gas burnt for all transactions is displayed in a section on the page.
- The application retains and displays historical transactions it has already fetched, even if they are no longer returned by the remote NEAR API.

## Architecture

### Backend

- **Ruby on Rails**: Provides API endpoints and handles data storage with Postgres. JSON serialization using Panko and Oj.
- **Sidekiq**: Runs workers that maintains a 1-minute interval cron sync with the NEAR API. Additional block writes triggers a recalculation of avg gas burnt. A potential unimplemented optimization is to debounce the trigger to save on redundant calls.

### Frontend

- **React**: Fetches data from the Rails API and displays it on the web page. App is transpiled with Rollup, and served via the Rails asset pipeline. Code is being transpiled with Terser plugin.
- **Tailwind CSS**: Used for styling the application with a modern and responsive design. Bundled with Rollup, and served via the Rails asset pipeline.

### Additional Chains

While the current implementation only supports the NEAR blockchain, the system is designed to be extensible to support additional blockchain networks in the future. This can be achieved by either creating new sync mechanisms against other Blockchains, for which the same model could apply on the UX front, albeit with a more generalized API as the current is specific to NEAR.

## Example Configuration

### Models

- **Blockchain**: Represents a blockchain network (e.g., NEAR).
- **Block**: Represents a block in the blockchain.
- **BlockTransaction**: Represents a transaction within a block.
- **Action**: Represents an action within a transaction.

### Controllers

- **PagesController**: Renders the root index page.
- **BlockTransactionsController**: Provides API endpoints for fetching transactions.

### Views

- **home.html.erb**: Root index page which our React app mounts to.
