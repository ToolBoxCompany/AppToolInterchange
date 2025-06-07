# 🛠 Tool Interchange App

**Tool Interchange App** es una aplicación de escritorio desarrollada en **Java + JavaFX** que permite gestionar el intercambio (alquiler o préstamo) de herramientas entre usuarios registrados. La aplicación utiliza **MariaDB** como base de datos, gestionada a través del entorno **XAMPP**.

---

## 📌 Funcionalidades principales

### 👤 Gestión de Usuarios
- Visualización de usuarios existentes.
- Diferenciación entre clientes y vendedores.
- Acceso al catálogo de productos del vendedor o al historial de órdenes del cliente.

### 🧰 Gestión de Productos (Vendedores)
- Añadir nuevas herramientas con nombre, stock, precio por día y categoría.
- Modificar el stock disponible.
- Eliminar herramientas del inventario personal.

### 📦 Gestión de Órdenes (Clientes)
- Visualización de órdenes asociadas al usuario.
- Edición de datos de la orden: cantidad, fechas, estado y método de pago.
- Recalculo automático del importe total según días y unidades alquiladas.

### 💳 Métodos de pago y estados
- Métodos disponibles: tarjeta, bizum, efectivo, transferencia, PayPal, etc.
- Estados de orden: `New`, `Paid`, `Cancelled`, `Sended`, `Returned`, `Closed`.

---

## 🗃 Base de Datos (XAMPP + MariaDB)

- Usa **MariaDB incluida en XAMPP**.
- La base de datos se llama `ToolInterchange`.
- Esquema relacional que incluye:
  - Usuarios y direcciones
  - Herramientas por categorías
  - Órdenes de reserva
  - Entregas, pagos y valoraciones

## ⚙️ Requisitos del sistema

- Java JDK 17 o superior
- JavaFX
- XAMPP instalado y activado (MySQL/MariaDB en el puerto `3307`)
- Base de datos `tool_interchange` ya creada y conectada
