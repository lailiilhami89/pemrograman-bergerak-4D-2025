import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../models/photo_model.dart';
import '../pages/gallery_page.dart';
import '../services/location_service.dart';
import '../services/notification_service.dart';
import '../services/connectivity_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _imageFile;
  String? _location;
  final List<PhotoModel> _photoList = [];

  final _titleController = TextEditingController();
  final _ownerController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _ownerController.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    final isOnline = await ConnectivityService().checkConnection();
    if (!isOnline) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak ada koneksi internet!')),
      );
      return;
    }

    await [
      Permission.camera,
      Permission.storage,
      Permission.location,
      Permission.notification,
    ].request();

    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    final file = File(image.path);
    await GallerySaver.saveImage(file.path);

    final position = await LocationService().getCurrentLocation();
    final locText = '${position.latitude}, ${position.longitude}';

    final photo = PhotoModel(
      imagePath: file.path,
      location: locText,
      timestamp: DateTime.now(),
      paintingName: _titleController.text,
      ownerName: _ownerController.text,
    );
    _photoList.add(photo);

    setState(() {
      _imageFile = image;
      _location = locText;
    });

    NotificationService().showNotification(
      title: 'Gambar Disimpan!',
      body: 'Lokasi: $_location',
    );
  }

  Future<void> _pickFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final file = File(image.path);

    final photo = PhotoModel(
      imagePath: file.path,
      location: 'Dari Galeri',
      timestamp: DateTime.now(),
      paintingName: _titleController.text,
      ownerName: _ownerController.text,
    );
    _photoList.add(photo);

    setState(() {
      _imageFile = image;
      _location = 'Dari Galeri';
    });

    NotificationService().showNotification(
      title: 'Foto Ditambahkan dari Galeri!',
      body: 'Nama Foto: ${_titleController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F7FA), Color(0xFFFFFFFF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 32,
                      color: Colors.lightBlue,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Galeri Lukisan',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Gambar + lokasi
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _imageFile != null
                            ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(_imageFile!.path),
                                height: 200,
                              ),
                            )
                            : Column(
                              children: const [
                                Icon(
                                  Icons.image_not_supported,
                                  size: 80,
                                  color: Colors.blueGrey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Belum ada gambar',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                        const SizedBox(height: 12),
                        if (_location != null)
                          Chip(
                            avatar: const Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.white,
                            ),
                            label: Text('Lokasi: $_location'),
                            backgroundColor: Colors.lightBlue,
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Input Text
                _buildInputField(
                  controller: _titleController,
                  label: 'Nama Gambar',
                  icon: Icons.brush,
                ),
                const SizedBox(height: 12),
                _buildInputField(
                  controller: _ownerController,
                  label: 'Nama Pemilik',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 24),

                // Tombol aksi
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildActionButton(
                      onPressed: _takePicture,
                      icon: Icons.camera,
                      label: 'Ambil Gambar',
                      color: Colors.teal,
                    ),
                    _buildActionButton(
                      onPressed: _pickFromGallery,
                      icon: Icons.photo,
                      label: 'Dari Galeri',
                      color: Colors.orange,
                    ),
                    _buildActionButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => GalleryPage(photos: _photoList),
                          ),
                        );
                      },
                      icon: Icons.photo_library,
                      label: 'Lihat Galeri',
                      color: Colors.purple,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.blueGrey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
