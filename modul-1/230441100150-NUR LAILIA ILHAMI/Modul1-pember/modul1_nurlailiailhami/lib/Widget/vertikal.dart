import 'package:flutter/material.dart';
import 'package:modul1_nurlailiailhami/pages/second.dart';

class ListVertical extends StatelessWidget {
  const ListVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> parkData = [
      {
        'title': 'Labuan Bajo',
        'description': 'Sebagai salah satu destinasi super prioritas dikalangan banyak orang dengan pemandangan yang keren.',
        'imageUrl': 'https://images.pexels.com/photos/132037/pexels-photo-132037.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      },
      {
        'title': 'Patung Liberty',
        'description': 'Patung Liberty Selama inimenjadi sumber makanan utama bagi penduduk tahun 1807 Angkatan Darat AS menganggap pulau itu sebagai pos militer.',
        'imageUrl': 'https://images.pexels.com/photos/356844/pexels-photo-356844.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      },
      {
        'title': 'Pandawa Beach',
        'description': 'Pantai Pandawa tempat wisata di area Kecamatan Kuta Selatan,Bali Di sekitar pantai ini terdapat tebing yang pada salah satu terdapat lima Patung Pandawa dan Kunti.',
        'imageUrl': 'https://images.pexels.com/photos/3855892/pexels-photo-3855892.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      },
      {
        'title': 'Shibuya Crossing',
        'description': 'Penyeberangan Shibuya adalah penyeberangan pejalan kaki tersibuk di dunia, dengan sekitar 3.000 orang menyeberang pada suatu waktu.',
        'imageUrl': 'https://images.pexels.com/photos/1619561/pexels-photo-1619561.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      },
      {
        'title': 'shanghai Tower',
        'description': 'Shanghai Tower adalah gedung pencakar langit megatall setinggi 128 lantai dan 632 meter yang terletak di Lujiazui.',
        'imageUrl': 'https://images.pexels.com/photos/936722/pexels-photo-936722.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      },
    ];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: parkData.length,
        itemBuilder: (context, index) {
          final park = parkData[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ParkInfoCard(
              title: park['title']!,
              description: park['description']!,
              imageUrl: park['imageUrl']!,
            ),
          );
        },
      ),
    );
  }
}

class ParkInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ParkInfoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(
              title: title,
              description: description,
              imagePath: imageUrl, 
              location: 'Default Location',
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: const Color.fromARGB(246, 238, 239, 240),
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade300,
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image, color: Colors.white),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}