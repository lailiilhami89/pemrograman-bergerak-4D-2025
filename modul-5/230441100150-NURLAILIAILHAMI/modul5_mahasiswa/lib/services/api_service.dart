import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/mahasiswa.dart';

class ApiService {
  static const String baseUrl = 'http://172.16.12.43/modul5';

  static Future<List<Mahasiswa>> fetchMahasiswa() async {
    final response = await http.get(Uri.parse('$baseUrl/get.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((item) => Mahasiswa.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data mahasiswa');
    }
  }

  static Future<void> addMahasiswa(Mahasiswa mhs) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'nama': mhs.nama,
        'nim': mhs.nim,
        'alamat': mhs.alamat,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal menambahkan mahasiswa');
    }
  }

  static Future<void> updateMahasiswa(Mahasiswa mhs) async {
    final response = await http.put(
      Uri.parse('$baseUrl/put.php'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': mhs.id,
        'nama': mhs.nama,
        'nim': mhs.nim,
        'alamat': mhs.alamat,
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Gagal memperbarui data mahasiswa');
    }
  }

  static Future<void> deleteMahasiswa(String nim) async {
    final response = await http.delete(Uri.parse('$baseUrl/del.php?nim=$nim'));
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus mahasiswa');
    }
  }
}
