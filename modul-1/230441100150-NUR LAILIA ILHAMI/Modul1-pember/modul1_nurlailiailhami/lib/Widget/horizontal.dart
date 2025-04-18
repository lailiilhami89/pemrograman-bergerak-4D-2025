import 'package:flutter/material.dart';
import 'package:modul1_nurlailiailhami/pages/second.dart';

class ListHorizontal extends StatelessWidget {
  const ListHorizontal({Key? key}) : super(key: key);

  final List<Map<String, String>> parkData = const [
    {
      'title': 'Labuan Bajo',
      'location': 'NTT',
      'description': 'Destinasi wisata bahari terkenal di Nusa Tenggara Timur dengan pemandangan laut yang memukau.',
      'imageUrl': 'https://images.pexels.com/photos/132037/pexels-photo-132037.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    },
    {
      'title': 'Patung Liberty',
      'location': 'New York',
      'description': 'Simbol kebebasan dan demokrasi yang ikonik di Amerika Serikat.',
      'imageUrl': 'https://images.pexels.com/photos/356844/pexels-photo-356844.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    },
    {
      'title': 'Pandawa Beach',
      'location': 'Bali',
      'description': 'Pantai tersembunyi di balik tebing dengan pasir putih dan air jernih.',
      'imageUrl': 'https://images.pexels.com/photos/3855892/pexels-photo-3855892.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    },
    {
      'title': 'Shibuya Crossing',
      'location': 'Japan',
      'description': 'Persimpangan tersibuk di dunia dengan lampu lalu lintas serentak.',
      'imageUrl': 'https://images.pexels.com/photos/1619561/pexels-photo-1619561.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    },
    {
      'title': 'Shanghai Tower',
      'location': 'Tiongkok',
      'description': 'Gedung pencakar langit tertinggi kedua di dunia yang menakjubkan.',
      'imageUrl': 'https://images.pexels.com/photos/936722/pexels-photo-936722.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double cardHeight = 100;
    final double cardWidth = 250;

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: parkData.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final park = parkData[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(
                      title: park['title']!,
                      location: park['location']!,
                      description: park['description']!,
                      imagePath: park['imageUrl']!,
                    ),
                  ),
                );
              },
              child: ParkCard(
                title: park['title']!,
                location: park['location']!,
                imageUrl: park['imageUrl']!,
                width: cardWidth,
                height: cardHeight,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ParkCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final double width;
  final double height;

  const ParkCard({
    Key? key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageSize = height * 0.6;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(246, 156, 108, 108),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: const Color.fromARGB(255, 174, 102, 102),
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
