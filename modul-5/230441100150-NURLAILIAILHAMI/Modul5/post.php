<?php
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
include 'koneksi.php';

$nim = $_POST['nim'] ?? '';
$nama = $_POST['nama'] ?? '';
$alamat = $_POST['alamat'] ?? '';

if (empty($nim) || empty($nama) || empty($alamat)) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Semua field wajib diisi']);
    exit();
}

$post_method = mysqli_query($conn, "INSERT INTO mahasiswa (nim, nama, alamat) VALUES ('$nim', '$nama', '$alamat')");

if ($post_method) {
    echo json_encode([
        "success" => true,
        "message" => "Data inserted successfully",
        "data" => [
            "nim" => $nim,
            "nama" => $nama,
            "alamat" => $alamat
        ]
    ]);
} else {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Failed to insert data: " . mysqli_error($conn)
    ]);
}
?>
