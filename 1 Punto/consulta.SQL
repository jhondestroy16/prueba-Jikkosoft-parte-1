-- 1. Diseñar un esquema de base de datos para una plataforma de blogs
-- sencilla. La plataforma debe admitir usuarios, publicaciones de blog,
-- comentarios y etiquetas.

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

--Inserts
INSERT INTO users (name, email, password, bio, created_at, updated_at)
VALUES
('Juan Pérez', 'juan@example.com', 'hashedpassword1', 'Apasionado por la tecnología y el café.', NOW(), NOW()),
('María Gómez', 'maria@example.com', 'hashedpassword2', 'Escritora y amante de los viajes.', NOW(), NOW()),
('Carlos Ruiz', 'carlos@example.com', 'hashedpassword3', 'Desarrollador fullstack y blogger.', NOW(), NOW());

INSERT INTO posts (user_id, title, slug, summary, content, published, published_at, created_at, updated_at)
VALUES
(1, 'Primer Post', 'primer-post', 'Resumen del primer post', 'Contenido del primer post', TRUE, NOW(), NOW(), NOW()),
(2, 'Segundo Post', 'segundo-post', 'Resumen del segundo post', 'Contenido del segundo post', TRUE, NOW(), NOW(), NOW()),
(3, 'Tercer Post', 'tercer-post', 'Resumen del tercer post', 'Contenido del tercer post', TRUE, NOW(), NOW(), NOW());

INSERT INTO comments (post_id, user_id, author_name, author_email, content, approved, created_at, updated_at)
VALUES
(1, 1, 'Juan Pérez', 'juan@example.com', 'Este es un comentario', TRUE, NOW(), NOW()),
(2, 2, 'María Gómez', 'maria@example.com', 'Este es otro comentario', TRUE, NOW(), NOW()),
(3, 3, 'Carlos Ruiz', 'carlos@example.com', 'Este es un comentario final', TRUE, NOW(), NOW());

INSERT INTO tags (name, slug) VALUES
('Tecnología', 'tecnologia'),
('Viajes', 'viajes'),
('Blogging', 'blogging');

INSERT INTO post_tag (post_id, tag_id) VALUES
(1, 1),
(2, 2),
(3, 3);

--Consultas
SELECT * FROM users;
SELECT * FROM posts;
SELECT * FROM comments;
SELECT * FROM tags;
SELECT * FROM post_tag;

-- La primera consulta solo muestra relación entre posts y tags.
SELECT p.id AS post_id, p.title AS post_title, t.id AS tag_id, t.name AS tag_name
FROM post_tag pt
INNER JOIN posts p ON pt.post_id = p.id
INNER JOIN tags t ON pt.tag_id = t.id;

-- La segunda consulta amplía la info, mostrando además el autor y el slug de cada tag, ordenados por id de post.
SELECT p.id AS post_id, p.title AS post_title, u.name AS author, t.name AS tag_name, t.slug AS tag_slug
FROM post_tag pt
INNER JOIN posts p ON pt.post_id = p.id
INNER JOIN tags t ON pt.tag_id = t.id
INNER JOIN users u ON p.user_id = u.id
ORDER BY p.id;

