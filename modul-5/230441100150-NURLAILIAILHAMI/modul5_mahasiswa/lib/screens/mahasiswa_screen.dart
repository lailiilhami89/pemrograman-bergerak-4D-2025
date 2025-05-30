import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/api_service.dart';

class MahasiswaScreen extends StatefulWidget {
  const MahasiswaScreen({super.key});

  @override
  State<MahasiswaScreen> createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  late Future<List<Mahasiswa>> _mahasiswaFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _mahasiswaFuture = ApiService.fetchMahasiswa();
    });
  }

  void _showForm({Mahasiswa? mhs}) {
    final _namaController = TextEditingController(text: mhs?.nama ?? '');
    final _nimController = TextEditingController(text: mhs?.nim ?? '');
    final _alamatController = TextEditingController(text: mhs?.alamat ?? '');

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(mhs == null ? 'Tambah Mahasiswa' : 'Edit Mahasiswa'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: _namaController, decoration: const InputDecoration(labelText: 'Nama')),
              TextField(controller: _nimController, decoration: const InputDecoration(labelText: 'NIM')),
              TextField(controller: _alamatController, decoration: const InputDecoration(labelText: 'Alamat')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () async {
              final nama = _namaController.text.trim();
              final nim = _nimController.text.trim();
              final address = _alamatController.text.trim();

              if (nama.isEmpty || nim.isEmpty || address.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua field wajib diisi')));
                return;
              }

              try {
                if (mhs == null) {
                  // Tambah
                  await ApiService.addMahasiswa(Mahasiswa(id: '', nama: nama, nim: nim, alamat: address));
                } else {
                  // Update
                  await ApiService.updateMahasiswa(Mahasiswa(id: mhs.id, nama: nama, nim: nim, alamat: address));
                }
                Navigator.pop(context);
                _refreshData();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: Text(mhs == null ? 'Tambah' : 'Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String nim) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Hapus Data'),
      content: const Text('Yakin ingin menghapus data ini?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
        ElevatedButton(
          onPressed: () async {
            try {
              await ApiService.deleteMahasiswa(nim);
              Navigator.pop(context);
              _refreshData();
            } catch (e) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
          child: const Text('Hapus'),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: FutureBuilder<List<Mahasiswa>>(
        future: _mahasiswaFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final mahasiswaList = snapshot.data ?? [];

          if (mahasiswaList.isEmpty) {
            return const Center(child: Text('Data mahasiswa kosong'));
          }

          return ListView.builder(
            itemCount: mahasiswaList.length,
            itemBuilder: (context, index) {
              final m = mahasiswaList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(m.nama),
                  subtitle: Text('NIM: ${m.nim}\nAlamat: ${m.alamat}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showForm(mhs: m),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(m.nim),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
