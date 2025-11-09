<?php
// Adatbázis kapcsolat beállítása
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "gshock_mods";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
	die("Connection failed: " . $conn->connect_error);
}

// Alkatrész variánsok listázása (part_options)
$sql = "SELECT po.id, p.name AS part_type, po.name AS option_name, c.name AS color, po.material, po.price, po.image_url FROM part_options po LEFT JOIN parts p ON po.part_id = p.id LEFT JOIN colors c ON po.color_id = c.id ORDER BY p.name, po.name";
$result = $conn->query($sql);

echo "<h2>Elérhető alkatrész variánsok</h2>";
if ($result && $result->num_rows > 0) {
	echo "<table border='1' cellpadding='8' style='border-collapse:collapse;'>";
	echo "<tr><th>Típus</th><th>Név</th><th>Szín</th><th>Anyag</th><th>Ár (Ft)</th><th>Kép</th></tr>";
	while($row = $result->fetch_assoc()) {
		echo "<tr>";
		echo "<td>" . htmlspecialchars($row['part_type']) . "</td>";
		echo "<td>" . htmlspecialchars($row['option_name']) . "</td>";
		echo "<td>" . htmlspecialchars($row['color'] ?? '-') . "</td>";
		echo "<td>" . htmlspecialchars($row['material'] ?? '-') . "</td>";
	    echo "<td>" . number_format($row['price'], 0, '', ' ') . " Ft</td>";
		if (!empty($row['image_url'])) {
			echo "<td><img src='" . htmlspecialchars($row['image_url']) . "' alt='" . htmlspecialchars($row['option_name']) . "' style='max-width:80px;max-height:80px;'></td>";
		} else {
			echo "<td>-</td>";
		}
		echo "</tr>";
	}
	echo "</table>";
} else {
	echo "Nincs ilyen alkatrész variáns az adatbázisban.";
}

$conn->close();
