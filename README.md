# 🏥 MediBillz - Medical Shop Billing API

## 📌 Overview  
MediBillz is a **Django REST Framework (DRF) API** for managing a **Medical Shop Billing System**.  
It includes **user authentication, medicine management, billing, stock tracking, and reports**.

---

## 🚀 Features  
✅ **JWT Authentication** (Login, Logout, Role-based Access)  
✅ **Medicine Management** (Add, Update, Delete, Track Stock)  
✅ **Billing System** (Auto Price Calculation, Invoice Generation)  
✅ **Real-time Notifications** (Low Stock & Expiry Alerts)  
✅ **Admin Dashboard** (Sales Reports & Performance Metrics)  

---

## 📥 **Postman Collection**  
[![Run in Postman](https://run.pstmn.io/button.svg)](https://www.postman.com/grey-equinox-143107/medibillz/collection/cazzzdu/medibillz-medical-shop-billing-api)  

1️⃣ Click the **"Run in Postman"** button.  
2️⃣ Import the **Postman Collection** and set the environment variables:  
   ```
   base_url = http://127.0.0.1:8000
   token = <JWT_ACCESS_TOKEN_FROM_LOGIN>
   ```
3️⃣ Send requests and test APIs.

---

## 🛠️ Installation  

### **🔹 Prerequisites**  
- Python **3.9+**  
- PostgreSQL **13+**  
- Django **3.2+**  
- Django REST Framework  
- Docker

### **🔹 Step 1: Clone the Repository**  
To get started, clone the project from GitHub:
```sh
git clone https://github.com/Rayeesac/MediBillz.git
cd MediBillz
```

### **🔹 Step 2: Run the Application Using Docker**  
MediBillz comes with Docker support, making it easy to set up dependencies like PostgreSQL and Django in isolated containers.

🔹Start the Application
Run the following command to build and start the services in detached mode (-d):

```sh
docker-compose -f docker-compose.yml up -d --build
```
To check running containers, use:
```sh
docker ps
```
### **🔹 Step 3: Restore the Database**  
If you have a database backup (medibillz.sql), you can restore it into the running PostgreSQL container.

🔹 Run the Command
```sh
cat medibillz.sql | docker exec -i medi_postgres psql -U postgres
```

### **🔹 Step 4: Restart Docker Services**  
```sh
docker-compose -f docker-compose.yml down && docker-compose -f docker-compose.yml up -d
```

---

## 📌 API Endpoints  

### **1️⃣ Authentication APIs**
| Method | Endpoint | Description |
|--------|-------------|--------------------|
| `POST` | `/api/auth/register/` | Register a new user (Admin, Staff, Inventory Manager) |
| `POST` | `/api/auth/login/` | Get JWT access & refresh tokens |
| `POST` | `/api/auth/logout/` | Invalidate JWT token |

---

### **2️⃣ User Management APIs (Admin Only)**
| Method | Endpoint | Description |
|--------|-------------|--------------------|
| `GET` | `/api/users/` | Get all users |
| `GET` | `/api/users/{id}/` | Get a specific user |
| `PUT` | `/api/users/{id}/` | Update user details |
| `DELETE` | `/api/users/{id}/` | Delete a user |

---

### **3️⃣ Medicine Management APIs (Inventory Manager Only)**
| Method | Endpoint | Description |
|--------|-------------|--------------------|
| `POST` | `/api/medicines/` | Add a new medicine |
| `GET` | `/api/medicines/` | List all medicines |
| `GET` | `/api/medicines/{id}/` | Get medicine details |
| `PUT` | `/api/medicines/{id}/` | Update medicine details |
| `DELETE` | `/api/medicines/{id}/` | Delete a medicine |

---

### **4️⃣ Billing APIs (Staff Only)**
| Method | Endpoint | Description |
|--------|-------------|--------------------|
| `POST` | `/api/billing/` | Create a bill (Auto price calculation) |

📌 **Example Request:**
```json
{
    "items": [
        { "medicine": 2, "quantity": 2, "packaging_type": "box" },
        { "medicine": 1, "quantity": 1, "packaging_type": "pack" }
    ]
}
```

---

### **5️⃣ Dashboard APIs (Admin Only)**
| Method | Endpoint | Description |
|--------|-------------|--------------------|
| `GET` | `/api/dashboard/stock/` | Get available stock |
| `GET` | `/api/dashboard/reports/?start_date=YYYY-MM-DD&end_date=YYYY-MM-DD` | Get sales reports |

---

## 📧 **Contact & Support**  
For issues, feel free to open a GitHub issue or contact:  
📩 Email: **info.rayeesac@gmail.com**  
🔗 GitHub: [GitHub Repo](https://github.com/Rayeesac/MediBillz)
