class Pengeluaran {
  String? id;
  String keterangan;
  int jumlah;
  String tanggal;

  Pengeluaran(
      {this.id,
      required this.keterangan,
      required this.jumlah,
      required this.tanggal});

  factory Pengeluaran.fromJson(Map<String, dynamic> json, String id) {
    return Pengeluaran(
      id: id,
      keterangan: json['keterangan'],
      jumlah: json['jumlah'],
      tanggal: json['tanggal'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keterangan': keterangan,
      'jumlah': jumlah,
      'tanggal':
          tanggal, // Pastikan format tanggal di sini sesuai dengan yang diinginkan
    };
  }
}
