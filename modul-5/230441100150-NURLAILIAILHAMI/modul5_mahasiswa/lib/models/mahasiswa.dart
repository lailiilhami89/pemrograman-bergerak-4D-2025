class Mahasiswa {
  final String id;
  final String nama;
  final String nim;
  final String alamat;

  Mahasiswa({
    required this.id,
    required this.nama,
    required this.nim,
    required this.alamat,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      id: json['id']?.toString() ?? '',
      nama: json['nama'] ?? '',
      nim: json['nim']?.toString() ?? '',
      alamat: json['alamat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'alamat': alamat,
    };
  }
}
