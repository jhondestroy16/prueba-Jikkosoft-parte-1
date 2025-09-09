# Prueba Técnica – Software Engineer Semi Senior

Este repositorio contiene la solución a los **primeros dos puntos** de la prueba técnica para el puesto de **Software Engineer Semi Senior**.

---

## Punto 1: Diseño de Base de Datos (Blog)

Se diseñó el esquema para una **plataforma de blogs** con las siguientes entidades:

- **Usuarios (`users`)**
- **Publicaciones (`posts`)**
- **Comentarios (`comments`)**
- **Etiquetas (`tags`)**
- **Relación M:N entre publicaciones y etiquetas (`post_tag`)**

### 🗄️ Script SQL

El script se encuentra en la carpeta **`1 Punto/consulta.SQL`**  
Ejemplo de contenido:

```sql
CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  bio TEXT,
  created_at TIMESTAMP NULL DEFAULT NULL,
  updated_at TIMESTAMP NULL DEFAULT NULL
);

CREATE TABLE posts (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  summary VARCHAR(500),
  content LONGTEXT NOT NULL,
  published BOOLEAN NOT NULL DEFAULT FALSE,
  published_at TIMESTAMP NULL DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT NULL,
  updated_at TIMESTAMP NULL DEFAULT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE comments (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  post_id BIGINT NOT NULL,
  user_id BIGINT NULL,
  author_name VARCHAR(150) NULL,
  author_email VARCHAR(255) NULL,
  content TEXT NOT NULL,
  approved BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMP NULL DEFAULT NULL,
  updated_at TIMESTAMP NULL DEFAULT NULL,
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE tags (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  slug VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE post_tag (
  post_id BIGINT NOT NULL,
  tag_id BIGINT NOT NULL,
  PRIMARY KEY (post_id, tag_id),
  FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

-- Índices recomendados
CREATE INDEX idx_posts_user ON posts(user_id);
CREATE INDEX idx_comments_post ON comments(post_id);
CREATE INDEX idx_posts_published_at ON posts(published_at);
```

--

## Punto 2: Ejercicio Two Sum en JavaScript

Se implementó el algoritmo clásico **Two Sum** en JavaScript con complejidad **O(n)**.  
El objetivo es, dado un arreglo de números y un **target**, encontrar los **índices de los dos números** que suman el target.

### 📂 Archivos relacionados
- **`2 Punto/index.html`** → Vista en HTML con Bootstrap.  
- **`2 Punto/js/script.js`** → Lógica en JavaScript.  

### 🧮 Lógica de la función

```javascript
function funcion_dos(nums, target) {
    const seen = new Map();
    for (let i = 0; i < nums.length; i++) {
        const val = nums[i];
        const need = target - val;
        if (seen.has(need)) {
            return [seen.get(need), i];
        }
        seen.set(val, i);
    }
    return null;
}
```