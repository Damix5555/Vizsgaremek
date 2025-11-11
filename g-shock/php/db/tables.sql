-- Adatbázis létrehozása
CREATE DATABASE IF NOT EXISTS gshock_mods CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE gshock_mods;


-- USERS TÁBLA
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- PARTS TÁBLA (ALKATRÉSZ TÍPUSOK)
CREATE TABLE parts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT DEFAULT NULL
);

-- Alkatrészek/leírások
INSERT INTO parts (name, description) VALUES
('szíj', 'Óraszíj – resin, gumi, fém, stb.'),
('lunetta', 'Bezel vagy keret, ami az óra testét körbeveszi'),
('mutató', 'Óramutatók (óra, perc, másodperc)'),
('számlap', 'Dial / háttér dizájn');


-- COLORS TÁBLA
CREATE TABLE colors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code CHAR(7) DEFAULT NULL,
    image VARCHAR(255) DEFAULT NULL
);

-- Színek
INSERT INTO colors (name, hex_code) VALUES
('Fekete', '#000000'),
('Fehér', '#FFFFFF'),
('Piros', '#FF0000'),
('Kék', '#0000FF'),
('Zöld', '#00FF00'),
('Sárga', '#FFFF00');

--  PART_OPTIONS TÁBLA (ALKATRÉSZ VARIÁNSOK)
CREATE TABLE part_options (
    id INT AUTO_INCREMENT PRIMARY KEY,
    part_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    color_id INT DEFAULT NULL,
    image_url VARCHAR(255) DEFAULT NULL,
    material VARCHAR(50) DEFAULT NULL,
    price DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (part_id) REFERENCES parts(id) ON DELETE CASCADE,
    FOREIGN KEY (color_id) REFERENCES colors(id) ON DELETE SET NULL
);

-- Példa variánsok
INSERT INTO part_options (part_id, name, color_id, image_url, material, price) VALUES
(1, 'Resin Strap Black', 1, 'images/strap_black.png', 'resin', 15.99),
(1, 'Metal Strap Silver', NULL, 'images/strap_silver.png', 'stainless steel', 35.00),
(2, 'Red Bezel', 3, 'images/bezel_red.png', 'resin', 20.00),
(3, 'White Hands', 2, 'images/hands_white.png', 'metal', 10.00),
(4, 'Black Buttons', 1, 'images/buttons_black.png', 'metal', 8.00),
(5, 'Carbon Dial', NULL, 'images/dial_carbon.png', 'carbon fiber', 12.50);


-- BUILDS TÁBLA (FELHASZNÁLÓI ÓRÁK)
CREATE TABLE builds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT DEFAULT NULL,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_public BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

-- BUILD_PARTS TÁBLA (ALKATRÉSZEK EGY BUILDHEZ)
CREATE TABLE build_parts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    build_id INT NOT NULL,
    part_id INT NOT NULL,
    option_id INT NOT NULL,
    FOREIGN KEY (build_id) REFERENCES builds(id) ON DELETE CASCADE,
    FOREIGN KEY (part_id) REFERENCES parts(id) ON DELETE CASCADE,
    FOREIGN KEY (option_id) REFERENCES part_options(id) ON DELETE CASCADE
);
