-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2026. Ápr 23. 00:53
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `g-elite`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(50) NOT NULL,
  `entity_type` varchar(100) NOT NULL,
  `entity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `old_values` longtext DEFAULT NULL,
  `new_values` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `entity_type`, `entity_id`, `old_values`, `new_values`, `created_at`) VALUES
(1, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 20:40:50'),
(2, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 20:42:45'),
(3, 6, 'register', 'user', 6, NULL, '{\"username\":\"asd\",\"email\":\"asd@gmail.com\",\"role\":\"user\"}', '2026-04-22 21:25:46'),
(4, 6, 'logout', 'user', 6, NULL, '{\"email\":\"asd@gmail.com\"}', '2026-04-22 21:26:52'),
(5, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 21:27:58'),
(6, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 21:28:31'),
(7, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 21:59:25'),
(8, 1, 'create', 'product', 9, NULL, '{\"name\":\"test\",\"type\":\"case\",\"color\":\"test\",\"material\":\"test\",\"price\":\"10\",\"image_url\":\"storage\\/products\\/5zaaPGxcu6PnZ9QFJAhfkhu3rYHr2X09GLI5TP3f.jpg\",\"stock\":\"13\",\"is_active\":true,\"id\":9}', '2026-04-22 22:04:35'),
(9, 1, 'create', 'prebuilt_watch', 4, NULL, '{\"name\":\"test\",\"description\":\"testing\",\"price\":\"13\",\"image_url\":\"storage\\/prebuilt-watches\\/RYeIltUHUVDIBjNitWBUlUOJOmyROyzurSboAAAi.png\",\"stock\":\"13\",\"is_active\":true,\"id\":4}', '2026-04-22 22:05:47'),
(10, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 22:19:42'),
(11, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 22:19:44'),
(12, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 22:19:48'),
(13, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 22:20:56'),
(14, 1, 'update', 'order', 3, '{\"id\":3,\"user_id\":2,\"status\":\"pending\",\"total_price\":\"279.95\",\"address\":\"1111 Budapest Teszt elek 5\",\"phone\":\"+36301234567\",\"created_at\":\"2026-04-20 16:15:51\"}', '{\"id\":3,\"user_id\":2,\"status\":\"cancelled\",\"total_price\":\"279.95\",\"address\":\"1111 Budapest Teszt elek 5\",\"phone\":\"+36301234567\",\"created_at\":\"2026-04-20 16:15:51\"}', '2026-04-22 22:21:25'),
(15, 1, 'update', 'order', 4, '{\"id\":4,\"user_id\":2,\"status\":\"pending\",\"total_price\":\"429.94\",\"address\":\"Test elek 13, Budapest\",\"phone\":\"+36701234567\",\"created_at\":\"2026-04-22 19:08:54\"}', '{\"id\":4,\"user_id\":2,\"status\":\"completed\",\"total_price\":\"429.94\",\"address\":\"Test elek 13, Budapest\",\"phone\":\"+36701234567\",\"created_at\":\"2026-04-22 19:08:54\"}', '2026-04-22 22:48:55'),
(16, 1, 'update', 'order', 4, '{\"id\":4,\"user_id\":2,\"status\":\"completed\",\"total_price\":\"429.94\",\"address\":\"Test elek 13, Budapest\",\"phone\":\"+36701234567\",\"created_at\":\"2026-04-22 19:08:54\"}', '{\"id\":4,\"user_id\":2,\"status\":\"pending\",\"total_price\":\"429.94\",\"address\":\"Test elek 13, Budapest\",\"phone\":\"+36701234567\",\"created_at\":\"2026-04-22 19:08:54\"}', '2026-04-22 22:48:58'),
(17, 1, 'update', 'order', 4, '{\"id\":4,\"user_id\":2,\"status\":\"pending\",\"total_price\":\"429.94\",\"address\":\"Test elek 13, Budapest\",\"phone\":\"+36701234567\",\"created_at\":\"2026-04-22 19:08:54\"}', '{\"id\":4,\"user_id\":2,\"status\":\"completed\",\"total_price\":\"429.94\",\"address\":\"Test elek 13, Budapest\",\"phone\":\"+36701234567\",\"created_at\":\"2026-04-22 19:08:54\"}', '2026-04-22 22:49:02'),
(18, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 23:16:50'),
(19, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 23:16:51'),
(20, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 23:35:23'),
(21, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 23:35:57'),
(22, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 23:35:58'),
(23, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-22 23:39:34'),
(24, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-22 23:39:37'),
(25, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-23 00:06:42'),
(26, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-23 00:13:45'),
(27, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-23 00:13:47'),
(28, 1, 'logout', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\"}', '2026-04-23 00:42:01'),
(29, 1, 'login', 'user', 1, NULL, '{\"email\":\"admin@gelite.com\",\"role\":\"admin\"}', '2026-04-23 00:48:30');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `configuration_parts`
--

CREATE TABLE `configuration_parts` (
  `id` int(11) NOT NULL,
  `configuration_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `configuration_parts`
--

INSERT INTO `configuration_parts` (`id`, `configuration_id`, `product_id`) VALUES
(1, 1, 1),
(2, 1, 3),
(3, 1, 5),
(4, 1, 7),
(5, 2, 2),
(6, 2, 4),
(7, 2, 5),
(8, 2, 8),
(9, 3, 1),
(10, 3, 3),
(11, 3, 5),
(12, 3, 7),
(13, 4, 1),
(14, 4, 4),
(15, 4, 6),
(16, 4, 7);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2026_04_22_180307_create_personal_access_tokens_table', 1),
(2, '2026_04_22_180346_create_audit_logs_table', 2);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` enum('pending','completed','cancelled') DEFAULT 'pending',
  `total_price` decimal(10,2) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `total_price`, `address`, `phone`, `created_at`) VALUES
(1, 2, 'completed', 149.99, 'Bécsi út 134', '+36301234567', '2026-03-10 14:20:33'),
(2, 3, 'pending', 124.96, 'Debrecen Kossuth tér 4', '+36307654321', '2026-03-10 14:20:33'),
(3, 2, 'cancelled', 279.95, '1111 Budapest Teszt elek 5', '+36301234567', '2026-04-20 16:15:51'),
(4, 2, 'completed', 429.94, 'Test elek 13, Budapest', '+36701234567', '2026-04-22 19:08:54');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `configuration_id` int(11) DEFAULT NULL,
  `prebuilt_watch_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT 1,
  `price` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `configuration_id`, `prebuilt_watch_id`, `quantity`, `price`) VALUES
(1, 1, NULL, 1, 1, 149.99),
(2, 2, 2, NULL, 1, 124.96),
(3, 3, 1, NULL, 1, 119.96),
(4, 3, NULL, 2, 1, 159.99),
(5, 4, 4, NULL, 1, 119.96),
(6, 4, NULL, 2, 1, 159.99),
(7, 4, NULL, 1, 1, 149.99);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(13, 'App\\Models\\User', 1, 'auth_token', 'ede5a498a984732ff073f90ad660cf98b5bb33f268ed5d7128cb2cf8ac2e2c7a', '[\"admin\",\"user\"]', '2026-04-22 20:52:19', NULL, '2026-04-22 20:48:30', '2026-04-22 20:52:19');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `prebuilt_watches`
--

CREATE TABLE `prebuilt_watches` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `prebuilt_watches`
--

INSERT INTO `prebuilt_watches` (`id`, `name`, `description`, `price`, `image_url`, `stock`, `is_active`, `created_at`) VALUES
(1, 'Classic Steel', 'Minimal steel watch with blue dial and leather strap', 149.99, 'classic_steel.png', 9, 1, '2026-03-10 14:20:33'),
(2, 'Ocean Blue', 'Sport style watch with blue dial and steel strap', 159.99, 'ocean_blue.png', 6, 1, '2026-03-10 14:20:33'),
(3, 'Midnight Black', 'All black elegant watch design', 139.99, 'midnight_black.png', 12, 1, '2026-03-10 14:20:33'),
(4, 'test', 'testing', 13.00, 'storage/prebuilt-watches/RYeIltUHUVDIBjNitWBUlUOJOmyROyzurSboAAAi.png', 13, 1, '2026-04-22 22:05:47');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `type` enum('case','strap','dial','hands') DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `material` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`id`, `name`, `type`, `color`, `material`, `price`, `image_url`, `stock`, `is_active`) VALUES
(1, 'Black Steel Case', 'case', 'black', 'steel', 49.99, 'case_black.png', 18, 1),
(2, 'Silver Steel Case', 'case', 'silver', 'steel', 54.99, 'case_silver.png', 15, 1),
(3, 'Black Leather Strap', 'strap', 'black', 'leather', 29.99, 'strap_black.png', 29, 1),
(4, 'Steel Strap', 'strap', 'silver', 'steel', 39.99, 'strap_steel.png', 24, 1),
(5, 'Blue Dial', 'dial', 'blue', 'metal', 19.99, 'dial_blue.png', 39, 1),
(6, 'White Dial', 'dial', 'white', 'metal', 19.99, 'dial_white.png', 34, 1),
(7, 'Silver Hands', 'hands', 'silver', 'metal', 9.99, 'hands_silver.png', 48, 1),
(8, 'Gold Hands', 'hands', 'gold', 'metal', 12.99, 'hands_gold.png', 40, 1),
(9, 'test', 'case', 'test', 'test', 10.00, 'storage/products/5zaaPGxcu6PnZ9QFJAhfkhu3rYHr2X09GLI5TP3f.jpg', 13, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@gelite.com', '$2y$12$tJy7nkM4Um3hKIkh8iuWSuBZUyHjeq27GBq14M2RMDh29/iFyqjYa', 'admin', '2026-03-10 14:20:32'),
(2, 'dani', 'dani@gmail.com', '$2y$12$pgu7xzxQE4IUkr4DNzukDOCsZ2jHQODVgwCOYnkX.oLfEgHCNAHZS', 'user', '2026-03-10 14:20:32'),
(3, 'anna', 'anna@gmail.com', '$2y$12$B6I.OM1Ym7XLNgkV.iHrj.d7tS8JyY62QRm2I.QoioOgbOAxt7KGW', 'user', '2026-03-10 14:20:32'),
(4, 'erk', 'erik@gmail.com', '$2y$12$exsnwUjYaQysUHq3fj6YrOLALKQ6JAbiPzI3IXVYxWJ0Mnh90VA4i', 'user', '2026-03-10 14:20:32'),
(5, 'tesztuser', 'teszt@example.com', '$2y$12$vjp8H.tuqzINDPVW4acR9eVUWRTAZyv47TY2WPpoQ1SwpLdmgW2Ge', 'user', '2026-04-22 20:18:23'),
(6, 'asd', 'asd@gmail.com', '$2y$12$vdg3SlVUCtcaFJlcoWU7tO3qTxerzzidNMXYk4R/fHPZR46E10Uf.', 'user', '2026-04-22 21:25:46');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `watch_configurations`
--

CREATE TABLE `watch_configurations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `total_price` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `watch_configurations`
--

INSERT INTO `watch_configurations` (`id`, `user_id`, `name`, `total_price`, `created_at`) VALUES
(1, 2, 'Mate Custom Watch', 119.96, '2026-03-10 14:20:33'),
(2, 3, 'Anna Blue Build', 124.96, '2026-03-10 14:20:33'),
(3, 2, 'Teszt konfiguráció', 109.96, '2026-04-20 16:13:21'),
(4, 2, 'Frontendből mentett konfiguráció', 119.96, '2026-04-22 19:08:00');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_user_id_foreign` (`user_id`),
  ADD KEY `audit_logs_entity_type_entity_id_index` (`entity_type`,`entity_id`),
  ADD KEY `audit_logs_action_index` (`action`);

--
-- A tábla indexei `configuration_parts`
--
ALTER TABLE `configuration_parts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `configuration_id` (`configuration_id`),
  ADD KEY `product_id` (`product_id`);

--
-- A tábla indexei `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `configuration_id` (`configuration_id`),
  ADD KEY `prebuilt_watch_id` (`prebuilt_watch_id`);

--
-- A tábla indexei `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- A tábla indexei `prebuilt_watches`
--
ALTER TABLE `prebuilt_watches`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- A tábla indexei `watch_configurations`
--
ALTER TABLE `watch_configurations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT a táblához `configuration_parts`
--
ALTER TABLE `configuration_parts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT a táblához `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `prebuilt_watches`
--
ALTER TABLE `prebuilt_watches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `watch_configurations`
--
ALTER TABLE `watch_configurations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Megkötések a táblához `configuration_parts`
--
ALTER TABLE `configuration_parts`
  ADD CONSTRAINT `configuration_parts_ibfk_1` FOREIGN KEY (`configuration_id`) REFERENCES `watch_configurations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `configuration_parts_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Megkötések a táblához `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Megkötések a táblához `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`configuration_id`) REFERENCES `watch_configurations` (`id`),
  ADD CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`prebuilt_watch_id`) REFERENCES `prebuilt_watches` (`id`);

--
-- Megkötések a táblához `watch_configurations`
--
ALTER TABLE `watch_configurations`
  ADD CONSTRAINT `watch_configurations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
