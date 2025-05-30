<?php
header('Content-Type: application/json');
include 'koneksi.php';

$query = mysqli_query($conn, "SELECT * FROM mahasiswa");
$result = [];

while ($row = mysqli_fetch_assoc($query)) {
    $result[] = $row;
}

echo json_encode(['data' => $result]);
?>
