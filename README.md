# 💰 Account Ledger Server

[![PHP Version](https://img.shields.io/badge/PHP-8.0%2B-777BB4?style=for-the-badge&logo=php&logoColor=white)](https://www.php.net/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0)
[![MySQL](https://img.shields.io/badge/MySQL-5.7%2B-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)

A robust **RESTful API server** for personal finance and account ledger management built with PHP. This server provides comprehensive endpoints for managing users, accounts, and financial transactions with support for double-entry bookkeeping principles.

---

## 📋 Table of Contents

- [Features](#-features)
- [Architecture](#-architecture)
- [Database Schema](#-database-schema)
- [API Documentation](#-api-documentation)
- [Getting Started](#-getting-started)
- [Environment Configuration](#%EF%B8%8F-environment-configuration)
- [Development](#-development)
- [API Testing](#-api-testing)
- [Deployment](#-deployment)
- [Automated Database Backups](#-automated-database-backups)
- [Contributing](#-contributing)
- [License](#-license)
- [Author](#-author)

---

## ✨ Features

- **🔐 User Management**: Create and authenticate users with secure credentials
- **📁 Hierarchical Accounts**: Support for parent-child account relationships (Assets, Liabilities, Income, Expenses, Equity)
- **💸 Double-Entry Transactions**: Track money flow with `from_account` and `to_account` for accurate bookkeeping
- **📊 Transaction History**: Query transactions by user, account, date range, and more
- **🔄 CRUD Operations**: Full Create, Read, Update, Delete support for transactions
- **⚙️ Configuration Management**: Server-side configuration and version management
- **🗄️ Automated Backups**: GitHub Actions workflow for scheduled database backups
- **🌐 Cloud-Ready**: Pre-configured for Heroku and ClearDB MySQL deployment

---

## 🏗 Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          Client Applications                             │
│            (Mobile Apps, Web Apps, CLI Tools, etc.)                      │
└───────────────────────────────┬─────────────────────────────────────────┘
                                │ HTTP/HTTPS
                                ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        Account Ledger Server (PHP)                       │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │                         http_API/ Directory                          │ │
│  │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐                 │ │
│  │  │    Users     │ │   Accounts   │ │ Transactions │                 │ │
│  │  │  Endpoints   │ │  Endpoints   │ │  Endpoints   │                 │ │
│  │  └──────────────┘ └──────────────┘ └──────────────┘                 │ │
│  │                           │                                          │ │
│  │                    config.php (DB Connection)                        │ │
│  │                    common_functions.php (Helpers)                    │ │
│  └─────────────────────────────────────────────────────────────────────┘ │
└───────────────────────────────┬─────────────────────────────────────────┘
                                │ mysqli
                                ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                           MySQL Database                                 │
│  ┌──────────┐  ┌──────────────┐  ┌────────────────┐  ┌──────────────┐  │
│  │  users   │  │   accounts   │  │ transactionsv2 │  │ configuration│  │
│  └──────────┘  └──────────────┘  └────────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────────────────────┘
```

### Tech Stack

| Component | Technology |
|-----------|------------|
| **Language** | PHP 8.0+ |
| **Database** | MySQL 5.7+ / MariaDB |
| **Extensions** | mysqli, json, gettext |
| **Package Manager** | Composer |
| **Deployment** | Heroku, Any PHP-enabled web server |
| **CI/CD** | GitHub Actions |

---

## 🗄 Database Schema

### Entity Relationship Diagram

```
┌──────────────────────────────────────────────────────────────────────────┐
│                              users                                        │
│  ┌────────────┬───────────────────┬─────────────────────────────────────┐ │
│  │     id     │     username      │              password               │ │
│  │  INT (PK)  │    VARCHAR(50)    │             VARCHAR(255)            │ │
│  └────────────┴───────────────────┴─────────────────────────────────────┘ │
└────────────────────────────────────┬─────────────────────────────────────┘
                                     │ 1:N
                                     ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                             accounts                                      │
│  ┌──────────────┬─────────────────────────────────────────────────────┐  │
│  │  account_id  │  full_name, name, parent_account_id, account_type,  │  │
│  │  INT (PK)    │  notes, commodity_type, commodity_value, owner_id,  │  │
│  │              │  taxable, place_holder, insertion_date_time         │  │
│  └──────────────┴─────────────────────────────────────────────────────┘  │
│         │                                                                 │
│         │ self-reference (parent_account_id → account_id)                │
│         ▼                                                                 │
└──────────────────────────────────────────────────────────────────────────┘
                                     │ 1:N (from/to)
                                     ▼
┌──────────────────────────────────────────────────────────────────────────┐
│                          transactionsv2                                   │
│  ┌────────────┬──────────────────────────────────────────────────────┐   │
│  │     id     │  event_date_time, particulars, amount,               │   │
│  │  INT (PK)  │  insertion_date_time, inserter_id,                   │   │
│  │            │  from_account_id (FK), to_account_id (FK)            │   │
│  └────────────┴──────────────────────────────────────────────────────┘   │
└──────────────────────────────────────────────────────────────────────────┘
```

### Account Types

The system supports standard accounting categories:

| Type | Description | Examples |
|------|-------------|----------|
| **ASSET** | Resources owned | Cash, Bank Accounts, Investments |
| **LIABILITY** | Debts and obligations | Loans, Credit Cards, Payables |
| **INCOME** | Revenue sources | Salary, Interest, Dividends |
| **EXPENSE** | Costs incurred | Food, Transport, Utilities |
| **EQUITY** | Owner's capital | Initial Capital, Retained Earnings |

### Database Views

| View Name | Purpose |
|-----------|---------|
| `recent_accounts` | Latest accounts ordered by ID descending |
| `recent_transactions` | Latest legacy transactions |
| `recent_transactionsv2` | Latest v2 transactions with account references |

---

## 📡 API Documentation

### Base URL

```
https://your-server.com/http_API/
```

### Response Format

All endpoints return JSON responses with a `status` field:

```json
{
  "status": 0,        // 0 = success, 1 = error/not found, 2 = empty result
  "error": "...",     // (optional) error message
  // ... other data
}
```

---

### 👤 User Endpoints

#### Get All Users
```http
GET /getUsers.php
```

**Response:**
```json
{
  "status": 0,
  "users": [
    { "id": "1", "username": "john", "password": "***" }
  ]
}
```

#### Create User
```http
POST /insertUser.php
Content-Type: application/x-www-form-urlencoded

username=john&passcode=secret123
```

**Response:**
```json
{ "status": 0 }
```

> **Note:** Creating a user automatically initializes 5 root accounts (Assets, Equity, Expenses, Income, Liabilities).

#### Authenticate User
```http
GET /select_User.php?username=john&password=secret123
```

**Response:**
```json
{ "user_count": "1", "id": "42" }
```

---

### 📁 Account Endpoints

#### Get All Accounts
```http
GET /getAccounts.php
```

**Response:**
```json
[
  { "status": "0" },
  {
    "account_id": "1",
    "full_name": "Assets",
    "name": "Assets",
    "parent_account_id": "0",
    "account_type": "ASSET",
    "notes": "",
    "commodity_type": "CURRENCY",
    "commodity_value": "INR",
    "owner_id": "1",
    "taxable": "F",
    "place_holder": "T",
    "insertion_date_time": "2024-01-01 00:00:00"
  }
]
```

#### Get User Accounts (by Parent)
```http
GET /select_User_Accounts.php?user_id=13&parent_account_id=0
```

#### Get All User Accounts
```http
GET /select_User_Accounts_full.php?user_id=13
```

**Response:**
```json
{
  "status": 0,
  "accounts": [...]
}
```

#### Get User Accounts V2
```http
GET /select_User_Accounts_v2.php?user_id=13&parent_account_id=0
```

#### Create Account
```http
POST /insert_Account.php
Content-Type: application/x-www-form-urlencoded

full_name=Assets:Bank:Savings
&name=Savings
&parent_account_id=10
&account_type=ASSET
&notes=
&commodity_type=CURRENCY
&commodity_value=INR
&owner_id=13
&taxable=F
&place_holder=F
```

---

### 💳 Transaction Endpoints

#### Get All Transactions (Legacy)
```http
GET /getTransactions.php
```

#### Get All Transactions V2
```http
GET /getTransactionsV2.php
```

#### Get User Transactions V2
```http
GET /select_User_Transactions_v2.php?user_id=13&account_id=16
```

**Response:**
```json
[
  { "status": "0" },
  {
    "id": "1234",
    "event_date_time": "2024-01-15 10:30:00",
    "particulars": "Grocery shopping",
    "amount": "1500.00",
    "insertion_date_time": "2024-01-15 10:35:00",
    "from_account_name": "Cash",
    "from_account_full_name": "Assets:Cash",
    "from_account_id": "16",
    "to_account_name": "Food",
    "to_account_full_name": "Expenses:Food",
    "to_account_id": "25"
  }
]
```

#### Get Recent User Transactions
```http
GET /select_Transactions_v2m.php?user_id=13
```

Returns the 10 most recent transactions.

#### Get Transactions After Date
```http
GET /select_User_Transactions_After_Specified_Date.php?user_id=13&specified_date=2024-01-01
```

#### Get Account Transactions (with Sub-accounts)
```http
GET /select_User_Transactions_v3.php?user_id=13&account_id=16
```

Recursively fetches transactions from the specified account and all child accounts.

#### Get Account-specific Transactions (Minimal)
```http
GET /select_User_Transactions_v2m.php?user_id=13&account_id=16
```

#### Create Transaction V2
```http
POST /insert_Transaction_v2.php
Content-Type: application/x-www-form-urlencoded

event_date_time=2024-01-15 10:30:00
&user_id=13
&particulars=Grocery shopping
&amount=1500.00
&from_account_id=16
&to_account_id=25
```

**Response:**
```json
{ "status": "0", "error": "" }
```

#### Update Transaction V2
```http
POST /update_Transaction_v2.php
Content-Type: application/x-www-form-urlencoded

id=1234
&event_date_time=2024-01-15 11:00:00
&particulars=Updated description
&amount=1600.00
&from_account_id=16
&to_account_id=25
```

#### Delete Transaction V2
```http
POST /delete_Transaction_v2.php
Content-Type: application/x-www-form-urlencoded

id=1234
```

---

### ⚙️ Configuration Endpoints

#### Get Configuration
```http
GET /getConfiguration.php
```

**Response:**
```json
[
  { "status": "0" },
  {
    "id": "1",
    "version_code": "25",
    "version_name": "1.0.25",
    "system_status": "1"
  }
]
```

#### Select Configuration
```http
GET /select_Configuration.php
```

Returns system status and version information.

---

## 🚀 Getting Started

### Prerequisites

- **PHP 8.0+** with the following extensions:
  - mysqli
  - json
  - gettext
- **MySQL 5.7+** or **MariaDB 10.2+**
- **Composer** (for dependency management)
- **Web Server**: Apache, Nginx, or PHP built-in server

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Baneeishaque/Account-Ledger-Server.git
   cd Account-Ledger-Server
   ```

2. **Install dependencies:**
   ```bash
   composer install
   ```

3. **Set up the database:**
   
   Import the database structure:
   ```bash
   mysql -u your_user -p your_database < db_structures/account_ledger_views.sql
   ```

   Or create tables manually based on the schema in `db_backups/`.

4. **Configure environment:**
   
   Set the `CLEARDB_DATABASE_URL` environment variable:
   ```bash
   export CLEARDB_DATABASE_URL="mysql://user:password@host/database?reconnect=true"
   ```

5. **Start the server:**
   
   Using PHP built-in server:
   ```bash
   php -S localhost:8000 -t http_API/
   ```

6. **Verify installation:**
   ```bash
   curl http://localhost:8000/getConfiguration.php
   ```

---

## ⚙️ Environment Configuration

### Database Connection

The server uses the `CLEARDB_DATABASE_URL` environment variable for database configuration. This format is compatible with Heroku's ClearDB add-on.

**Format:**
```
mysql://username:password@hostname/database_name
```

**Example:**
```bash
export CLEARDB_DATABASE_URL="mysql://b5c067bad:ZFXPXCs49@us-cdbr-iron-east-05.cleardb.net/heroku_0fd2194a537b978"
```

### Local Development

Create a `.env` file or set environment variables:

```bash
# Database Configuration
CLEARDB_DATABASE_URL=mysql://root:password@localhost/account_ledger

# For GitHub Actions Database Backup (optional)
DB_HOST=your.db.host
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_NAME=your_db_name
SERVER_NAME=your-server-name
```

---

## 💻 Development

### Project Structure

```
Account-Ledger-Server/
├── http_API/                    # PHP API endpoints
│   ├── config.php               # Database connection
│   ├── common_functions.php     # Shared helper functions
│   ├── getUsers.php             # User listing
│   ├── insertUser.php           # User creation
│   ├── select_User.php          # User authentication
│   ├── getAccounts.php          # Account listing
│   ├── insert_Account.php       # Account creation
│   ├── select_User_Accounts*.php # User-specific account queries
│   ├── getTransactions*.php     # Transaction listing
│   ├── insert_Transaction*.php  # Transaction creation
│   ├── update_Transaction_v2.php # Transaction update
│   ├── delete_Transaction_v2.php # Transaction deletion
│   └── *Configuration.php       # System configuration
├── api_test/                    # HTTP test files (JetBrains HTTP Client)
│   ├── http-client.env.json     # Environment variables
│   └── *.http                   # Request test files
├── db_scripts/                  # Utility SQL scripts
├── db_structures/               # Database schema definitions
├── db_backups/                  # Database backup files
├── .github/workflows/           # GitHub Actions CI/CD
├── composer.json                # PHP dependencies
└── README.md                    # This file
```

### Coding Standards

- Follow PSR-12 coding style guidelines
- Use meaningful variable and function names
- Add PHPDoc comments for functions
- Handle errors gracefully with proper JSON responses

### Adding New Endpoints

1. Create a new PHP file in `http_API/`
2. Include `config.php` for database connection
3. Use `filter_input()` for safe parameter handling
4. Return JSON responses with status codes
5. Add corresponding `.http` test file in `api_test/`

**Example (using prepared statements for security):**
```php
<?php
include_once 'config.php';

$param = filter_input(INPUT_GET, 'param_name');

// Use prepared statements to prevent SQL injection
$stmt = $con->prepare("SELECT * FROM table WHERE column = ?");
$stmt->bind_param("s", $param);
$stmt->execute();
$result = $stmt->get_result();

if (mysqli_num_rows($result) != 0) {
    $data = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = $row;
    }
    echo json_encode(["status" => 0, "data" => $data]);
} else {
    echo json_encode(["status" => 1]);
}

$stmt->close();
```

> ⚠️ **Security Note:** Always use prepared statements or parameterized queries to prevent SQL injection vulnerabilities.

---

## 🧪 API Testing

### Using JetBrains HTTP Client

The repository includes ready-to-use HTTP test files compatible with IntelliJ IDEA, PhpStorm, and other JetBrains IDEs.

1. Open the project in a JetBrains IDE
2. Navigate to `api_test/` directory
3. Select an environment from `http-client.env.json`
4. Run individual requests or entire test files

### Environment Configuration

Edit `api_test/http-client.env.json`:

```json
{
  "Heroku": {
    "host": "account-ledger-server.herokuapp.com",
    "http_API_folder": "http_API",
    "file_extension": "php"
  },
  "Local": {
    "host": "localhost:8000",
    "http_API_folder": "",
    "file_extension": "php"
  }
}
```

### Example Requests

**Test User Authentication:**
```http
GET https://{{host}}/{{http_API_folder}}/select_User.{{file_extension}}?username=test&password=test123
Accept: application/json
```

**Test Transaction Creation:**
```http
POST https://{{host}}/{{http_API_folder}}/insert_Transaction_v2.{{file_extension}}
Content-Type: application/x-www-form-urlencoded

event_date_time=2024-01-15 10:30:00
&user_id=13
&particulars=Test
&amount=100.00
&from_account_id=1
&to_account_id=2
```

### Using cURL

```bash
# Get all users
curl -X GET "http://localhost:8000/getUsers.php"

# Create a user
curl -X POST "http://localhost:8000/insertUser.php" \
  -d "username=newuser" \
  -d "passcode=password123"

# Get user accounts
curl -X GET "http://localhost:8000/select_User_Accounts_full.php?user_id=13"

# Create a transaction
curl -X POST "http://localhost:8000/insert_Transaction_v2.php" \
  -d "event_date_time=2024-01-15 10:30:00" \
  -d "user_id=13" \
  -d "particulars=Grocery shopping" \
  -d "amount=1500.00" \
  -d "from_account_id=16" \
  -d "to_account_id=25"
```

---

## 🚢 Deployment

### Heroku Deployment

1. **Create Heroku app:**
   ```bash
   heroku create your-app-name
   ```

2. **Add ClearDB MySQL:**
   ```bash
   heroku addons:create cleardb:ignite
   ```

3. **Deploy:**
   ```bash
   git push heroku main
   ```

4. **Verify:**
   ```bash
   heroku open
   curl https://your-app-name.herokuapp.com/http_API/getConfiguration.php
   ```

### Manual Server Deployment

1. Upload files to your web server's document root
2. Ensure the `http_API/` directory is accessible
3. Configure your web server to handle `.php` files
4. Set the `CLEARDB_DATABASE_URL` environment variable

### Apache Configuration

```apache
<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /var/www/html/Account-Ledger-Server
    
    <Directory /var/www/html/Account-Ledger-Server/http_API>
        AllowOverride All
        Require all granted
    </Directory>
    
    # Load environment variables from secure file
    # Option 1: Use SetEnvIf with environment file
    Include /etc/apache2/sites-available/account-ledger-env.conf
    
    # Option 2: Or reference system environment variables
    # PassEnv CLEARDB_DATABASE_URL
</VirtualHost>
```

Create `/etc/apache2/sites-available/account-ledger-env.conf` (chmod 600):
```apache
SetEnv CLEARDB_DATABASE_URL "mysql://user:pass@host/db"
```

> 🔒 **Security:** Never commit credentials to version control. Use separate environment files with restricted permissions.

### Nginx Configuration

```nginx
server {
    listen 80;
    server_name your-domain.com;
    root /var/www/html/Account-Ledger-Server;
    index index.php;

    location /http_API/ {
        try_files $uri $uri/ /http_API/index.php?$query_string;
    }

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        # Load environment from PHP-FPM pool config or .env file
        include fastcgi_params;
    }
}
```

---

## 🔄 Automated Database Backups

The repository includes a GitHub Actions workflow for automated database backups.

### How It Works

1. **Scheduled Runs**: Backups run 4 times daily (IST: 00:00, 06:00, 12:00, 18:00)
2. **On-Demand**: Trigger manually via workflow dispatch
3. **Storage**: Backups are committed to the repository in `db_backups/`

### Setup

1. **Add GitHub Secrets:**
   ```
   DB_HOST      - Database hostname
   DB_USER      - Database username
   DB_PASSWORD  - Database password
   DB_NAME      - Database name
   SERVER_NAME  - Identifier for backup files
   ```

2. **Reference:** See `act.secrets_sample` for a template:
   ```
   DB_HOST=your.db.host.or.ip
   DB_USER=your_db_user
   DB_PASSWORD=your_db_password
   DB_NAME=your_db_name
   SERVER_NAME=your-server-name-label
   GITHUB_TOKEN=ghp_your_personal_access_token
   ```

### Local Testing with Act

[Act](https://github.com/nektos/act) allows you to run GitHub Actions locally:

```bash
act -s DB_HOST=localhost -s DB_USER=root -s DB_PASSWORD=pass -s DB_NAME=account_ledger -s SERVER_NAME=local
```

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### Getting Started

1. **Fork the repository**
2. **Clone your fork:**
   ```bash
   git clone https://github.com/your-username/Account-Ledger-Server.git
   ```
3. **Create a feature branch:**
   ```bash
   git checkout -b feature/amazing-feature
   ```

### Development Process

1. **Make your changes** following the coding standards
2. **Test your changes** using the API test files
3. **Update documentation** if needed
4. **Commit your changes:**
   ```bash
   git commit -m "feat: add amazing feature"
   ```
5. **Push to your fork:**
   ```bash
   git push origin feature/amazing-feature
   ```
6. **Open a Pull Request**

### Commit Message Format

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

[optional body]
[optional footer]
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Code Review

- All pull requests require review before merging
- Ensure CI checks pass
- Respond to feedback promptly

### Reporting Issues

1. **Check existing issues** to avoid duplicates
2. **Use the issue template** if available
3. **Include:**
   - Clear description of the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (PHP version, OS, etc.)

---

## 📄 License

This project is licensed under the **GNU General Public License v3.0** - see the [LICENSE](LICENSE) file for details.

```
Account Ledger Server - A RESTful API for personal finance management
Copyright (C) 2024 Banee Ishaque K

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.
```

---

## 👤 Author

**Banee Ishaque K**

- 📧 Email: [Baneeishaque@gmail.com](mailto:Baneeishaque@gmail.com)
- 🐙 GitHub: [@Baneeishaque](https://github.com/Baneeishaque)

---

## 🙏 Acknowledgments

- Thanks to all contributors who have helped improve this project
- Built with ❤️ for the open-source community

---

<p align="center">
  <sub>Made with ☕ and PHP</sub>
</p>
