<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");
header('Content-Type: application/json');

include 'koneksi.php';

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $_DELETE);

    $nim = $_GET['nim'] ?? $_DELETE['nim'] ?? null;

    if ($nim) {
        $query = "DELETE FROM mahasiswa WHERE nim='$nim'";
        if (mysqli_query($conn, $query)) {
            if (mysqli_affected_rows($conn) > 0) {
                echo json_encode(['message' => 'Berhasil hapus']);
            } else {
                http_response_code(404);
                echo json_encode(['message' => 'Data tidak ditemukan']);
            }
        } else {
            http_response_code(500);
            echo json_encode(['message' => 'Gagal hapus', 'error' => mysqli_error($conn)]);
        }
    } else {
        http_response_code(400);
        echo json_encode(['message' => 'NIM tidak ditemukan']);
    }
} else {
    http_response_code(405);
    echo json_encode(['message' => 'Method not allowed']);
}
?>
