## 📄 Docker LAMP Stack with HTTPS

### 🔧 Overview

This project sets up a **LAMP (Linux + Apache + MySQL + PHP)** development or production environment using **Docker Compose**, complete with:

* Apache + PHP 8.2
* MySQL 8.0
* Optional phpMyAdmin
* HTTPS support:

  * ✅ Self-signed SSL for local development
  * ✅ Let's Encrypt for production with auto-renewal

---

### 📁 Project Structure

```
lamp-docker/
├── apache/
│   └── vhost.conf           # Apache virtual host configuration
├── certs/                   # SSL certificates (self-signed or Let's Encrypt)
├── certbot-etc/             # Certbot config and renewal data (Let's Encrypt)
├── html/                    # Your PHP application code
├── Dockerfile               # PHP + Apache base image
├── docker-compose.yml       # All services
└── README.md                # This documentation
```

---

### 🚀 Getting Started

#### 1. Clone or Create Your PHP Project

```bash
git clone https://github.com/your-username/your-php-app.git html
# or manually place code in ./html/
```

---

#### 2. Generate Self-Signed SSL (for Local Dev)

```bash
mkdir -p certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout certs/apache-selfsigned.key \
  -out certs/apache-selfsigned.crt \
  -subj "/C=US/ST=Dev/L=Local/O=Dev/CN=localhost"
```

---

#### 3. Build & Run the Stack

```bash
docker-compose up --build -d
```

* Access your app at: [https://localhost](https://localhost) (⚠️ browser will warn about the cert)

---

### ✅ MySQL Access

* **Host**: `db`
* **User**: `user`
* **Password**: `userpassword`
* **Database**: `mydb`

> You can also use [phpMyAdmin](http://localhost:8081) if the service is enabled in `docker-compose.yml`.

---

### 🔒 Optional: Let's Encrypt for HTTPS (Production)

#### Requirements:

* Own a domain (e.g. `example.com`)
* Point domain DNS to your server
* Ports 80 and 443 must be open

#### 1. Run Certbot One Time

```bash
docker run --rm \
  -v "$(pwd)/certbot-etc:/etc/letsencrypt" \
  -v "$(pwd)/html:/var/www/html" \
  certbot/certbot certonly --webroot \
  --webroot-path=/var/www/html \
  --email your-email@example.com \
  --agree-tos --no-eff-email \
  -d example.com -d www.example.com
```

#### 2. Restart Stack

```bash
docker-compose down
docker-compose up -d
```

#### 3. Renewal is Automatic

The `certbot` service will check and renew certificates every 12 hours.

Test it:

```bash
docker exec -it lamp-certbot certbot renew --dry-run
```

---

### 🧪 Debugging & Logs

```bash
docker logs lamp-web         # Apache logs
docker logs lamp-db          # MySQL logs
docker logs lamp-certbot     # Certbot logs (if using Let's Encrypt)
```

---

### 🧹 Cleanup

```bash
docker-compose down -v --remove-orphans
```

---

### 📌 Notes

* You can modify `apache/vhost.conf` for your specific needs (e.g., Laravel, WordPress).
* All source code should go in the `html/` folder.
* You can add more PHP extensions in the Dockerfile using `docker-php-ext-install`.

---

### 👨‍💻 Author & License

* Created by: **Dimas**
* License: **MIT**
