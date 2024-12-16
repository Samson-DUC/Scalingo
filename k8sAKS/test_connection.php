<?php
$host = "frontdoor-mysql-server.mysql.database.azure.com";
$username = "mysqladmin";
$password = "Password1234";
$database = "employees";

// Initialize MySQLi and set SSL options if needed
$conn = mysqli_init();
mysqli_ssl_set($conn, NULL, NULL, NULL, NULL, NULL);  // Adjust if using SSL cert

// Attempt connection
if (!mysqli_real_connect($conn, $host, $username, $password, $database, 3306, NULL, MYSQLI_CLIENT_SSL)) {
    die("Connection failed: " . mysqli_connect_error());
}

echo "Connected successfully to the Azure MySQL Flexible Server!<br>";

// Query to verify data
$result = $conn->query("SELECT id, name FROM employees");

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "ID: " . $row["id"] . " - Name: " . $row["name"] . "<br>";
    }
} else {
    echo "No data found in the employees table.";
}

$conn->close();
?>
