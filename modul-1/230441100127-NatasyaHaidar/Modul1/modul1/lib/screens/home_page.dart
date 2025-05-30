import 'package:flutter/material.dart';
import 'detail_page.dart';
import '../widgets/place_card.dart';
import '../widgets/hotel_card.dart';

class HomePage extends StatelessWidget {
  final List<Map<String, String>> hotPlaces = [
    {
      'title': 'National Park Yosemite',
      'location': 'California',
      'image': 'assets/yosemite.jpg',
      'description':
          'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.'
    },
    {
      'title': 'National Park Yosemite',
      'location': 'California',
      'image': 'assets/yosemite.jpg',
      'description':
          'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.'
    },
     {
      'title': 'National Park Yosemite',
      'location': 'California',
      'image': 'assets/yosemite.jpg',
      'description':
          'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.'
    },
     {
      'title': 'National Park Yosemite',
      'location': 'California',
      'image': 'assets/yosemite.jpg',
      'description':
          'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.'
    },
     {
      'title': 'National Park Yosemite',
      'location': 'California',
      'image': 'assets/yosemite.jpg',
      'description':
          'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.'
    },
  ];

  final List<Map<String, String>> bestHotels = [
    {
      'title': 'National Park Yosemite',
      'image': 'assets/yosemite.jpg',
      'description': 'A scenic hotel surrounded by natural beauty in Yosemite National Park.',
    },
    {
      'title': 'National Park Yosemite',
      'image': 'assets/yosemite.jpg',
      'description': 'A scenic hotel surrounded by natural beauty in Yosemite National Park.',
    },
     {
      'title': 'National Park Yosemite',
      'image': 'assets/yosemite.jpg',
      'description': 'A scenic hotel surrounded by natural beauty in Yosemite National Park.',
    },
     {
      'title': 'National Park Yosemite',
      'image': 'assets/yosemite.jpg',
      'description': 'A scenic hotel surrounded by natural beauty in Yosemite National Park.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Icon(Icons.arrow_back, size: 24, color: Colors.grey),
            Icon(Icons.circle_outlined, size: 24, color: Colors.grey),
            Icon(Icons.crop_square, size: 24, color: Colors.grey),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Status bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '9.41',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.signal_cellular_alt, size: 18),
                        SizedBox(width: 4),
                        Icon(Icons.wifi, size: 18),
                        SizedBox(width: 4),
                        Icon(Icons.battery_full, size: 18),
                      ],
                    )
                  ],
                ),

                const SizedBox(height: 24),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            Text("Hi, User", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            SizedBox(width: 6),
                            Text("👋", style: TextStyle(fontSize: 22)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text("Let’s Discover", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.greenAccent, width: 2),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage('assets/aku.jpg'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Hot Places
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Hot Places", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 12),

                //hotplaces
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hotPlaces.length,
                    itemBuilder: (context, index) {
                      final place = hotPlaces[index];
                      return PlaceCard(
                        imageUrl: place['image']!,
                        title: place['title']!,
                        location: place['location']!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(
                                title: place['title']!,
                                imagePath: place['image']!,
                                description: place['description']!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Best Hotels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Best Hotels", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("See All", style: TextStyle(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),

                ListView.builder(
                  itemCount: bestHotels.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final hotel = bestHotels[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: HotelCard(
                        imageUrl: hotel['image']!,
                        title: hotel['title']!,
                        description: hotel['description']!,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
