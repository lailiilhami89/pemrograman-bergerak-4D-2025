class PhotoModel {
  final String imagePath;
  final String location;
  final DateTime timestamp;
  final String paintingName;
  final String ownerName;

  PhotoModel({
    required this.imagePath,
    required this.location,
    required this.timestamp,
    required this.paintingName,
    required this.ownerName,
  });
}
