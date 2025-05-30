<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: PUT, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $_PUT);

    $nama = $_PUT['nama'] ?? '';
    $nim = $_PUT['nim'] ?? '';
    $alamat = $_PUT['alamat'] ?? '';

    if (empty($nama) || empty($nim) || empty($alamat)) {
        http_response_code(400);
        echo json_encode(['message' => 'Data tidak lengkap']);
        exit();
    }

    $nama = mysqli_real_escape_string($conn, $nama);
    $nim = mysqli_real_escape_string($conn, $nim);
    $alamat = mysqli_real_escape_string($conn, $alamat);

    $query = "UPDATE mahasiswa SET nim='$nim', alamat='$alamat' WHERE nama='$nama'";

    if (mysqli_query($conn, $query)) {
        if (mysqli_affected_rows($conn) > 0) {
            echo json_encode(['message' => 'Berhasil update']);
        } else {
            http_response_code(404);
            echo json_encode(['message' => 'Data tidak ditemukan atau tidak ada perubahan']);
        }
    } else {
        http_response_code(500);
        echo json_encode(['message' => 'Gagal update', 'error' => mysqli_error($conn)]);
    }
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Method not allowed']);
}
?>
