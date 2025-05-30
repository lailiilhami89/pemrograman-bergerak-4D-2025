import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/pengeluaran.dart'; // Pastikan model 'Pengeluaran' sudah benar diimpor
import '../services/pengeluaranservices.dart'; // Pastikan service sudah diimpor untuk fetch dan CRUD

class PengeluaranScreen extends StatefulWidget {
  @override
  _PengeluaranScreenState createState() => _PengeluaranScreenState();
}

class _PengeluaranScreenState extends State<PengeluaranScreen> {
  final PengeluaranService service = PengeluaranService();
  List<Pengeluaran> data = [];

  final TextEditingController keteranganController = TextEditingController();
  final TextEditingController jumlahController = TextEditingController();
  DateTime? selectedDate;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final hasil = await service.fetchAll();
    setState(() {
      data = hasil;
    });
  }

  String formatCurrency(int value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatter.format(value);
  }

  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMMM yyyy', 'id_ID').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Icon getIconForItem(String keterangan) {
    final text = keterangan.toLowerCase();
    if (text.contains('transportasi')) {
      return Icon(Icons.directions_bus, color: Colors.deepPurple);
    } else if (text.contains('baju')) {
      return Icon(Icons.shopping_bag, color: Colors.pink);
    } else if (text.contains('kas')) {
      return Icon(Icons.account_balance_wallet, color: Colors.green);
    } else if (text.contains('print') || text.contains('materi')) {
      return Icon(Icons.print, color: Colors.orange);
    } else {
      return Icon(Icons.money, color: Colors.blueGrey);
    }
  }

  Future<void> showForm({Pengeluaran? pengeluaran}) async {
    if (pengeluaran != null) {
      keteranganController.text = pengeluaran.keterangan;
      jumlahController.text = pengeluaran.jumlah.toString();
      selectedDate = DateTime.tryParse(pengeluaran.tanggal);
    } else {
      keteranganController.clear();
      jumlahController.clear();
      selectedDate = null;
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          pengeluaran == null ? 'Tambah Pengeluaran' : 'Edit Pengeluaran',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: keteranganController,
                decoration: InputDecoration(
                  labelText: 'Keterangan',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: jumlahController,
                decoration: InputDecoration(
                  labelText: 'Jumlah',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'Tanggal belum dipilih'
                          : DateFormat('dd MMMM yyyy', 'id_ID')
                              .format(selectedDate!),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    icon: Icon(Icons.date_range),
                    label: Text('Pilih Tanggal'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              if (selectedDate == null ||
                  keteranganController.text.isEmpty ||
                  jumlahController.text.isEmpty ||
                  int.tryParse(jumlahController.text) == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Harap isi semua field dengan benar')),
                );
                return;
              }

              final item = Pengeluaran(
                id: pengeluaran?.id,
                keterangan: keteranganController.text,
                jumlah: int.parse(jumlahController.text),
                tanggal: DateFormat('yyyy-MM-dd').format(selectedDate!),
              );

              if (pengeluaran == null) {
                await service.addPengeluaran(item);
              } else {
                await service.updatePengeluaran(item);
              }

              Navigator.of(context).pop();
              loadData();
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> confirmDelete(String id) async {
    await service.deletePengeluaran(id);
    loadData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Pengeluaran Kuliah')),
        backgroundColor: Colors.green,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: data.isEmpty
                ? Center(child: Text('Belum ada data.'))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      final item = data[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 6),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey.shade200,
                            child: getIconForItem(item.keterangan),
                          ),
                          title: Text(item.keterangan,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(
                              '${formatCurrency(item.jumlah)}\n${formatDate(item.tanggal)}'),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => showForm(pengeluaran: item),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => confirmDelete(item.id!),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                      child: Text("CRUD Pembayaran belum diimplementasikan")),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Contoh button untuk tambah pembayaran
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Fitur pembayaran belum tersedia')),
                    );
                  },
                  child: Text("Tambah Pembayaran"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengaturan Aplikasi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: Icon(Icons.palette, color: Colors.deepPurple),
                    ),
                    title: Text('Mode Gelap'),
                    subtitle: Text('Aktifkan tema gelap (belum aktif)'),
                    trailing: Switch(
                      value: false,
                      onChanged: (val) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Fitur mode gelap belum tersedia')),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: Icon(Icons.info_outline, color: Colors.blue),
                    ),
                    title: Text('Tentang Aplikasi'),
                    subtitle: Text('Versi 1.0.0'),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Pengeluaran Kuliah',
                        applicationVersion: '1.0.0',
                        applicationIcon: Icon(Icons.school),
                        children: [
                          Text(
                              'Aplikasi ini membantu mencatat dan memantau pengeluaran harian selama kuliah.'),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: Icon(Icons.logout, color: Colors.red),
                    ),
                    title: Text('Keluar'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur keluar belum tersedia')),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showForm(),
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Pembayaran',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
