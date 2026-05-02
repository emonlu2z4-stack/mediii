class Doctor {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int reviewCount;
  final String experience;
  final String hospital;
  final String location;
  final double fee;
  final String about;
  final bool available;
  final String imagePath;
  final List<String> availableSlots;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.reviewCount,
    required this.experience,
    required this.hospital,
    required this.location,
    required this.fee,
    required this.about,
    required this.available,
    required this.imagePath,
    required this.availableSlots,
  });
}
