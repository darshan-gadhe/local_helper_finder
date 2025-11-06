class ServiceProvider {
  final String name;
  final String service;
  final String imageUrl;
  final double rating;
  final int jobsDone;
  final bool isVerified;

  ServiceProvider({
    required this.name,
    required this.service,
    required this.imageUrl,
    required this.rating,
    required this.jobsDone,
    this.isVerified = false,
  });
}

// Dummy Data for demonstration
final List<ServiceProvider> popularProviders = [
  ServiceProvider(
    name: "Ramesh Kumar",
    service: "Plumber",
    imageUrl: "https://i.imgur.com/yN29131.png", // Using generic placeholder images
    rating: 4.8,
    jobsDone: 120,
    isVerified: true,
  ),
  ServiceProvider(
    name: "Sunita Sharma",
    service: "Electrician",
    imageUrl: "https://i.imgur.com/L7Le2v1.png",
    rating: 4.9,
    jobsDone: 250,
    isVerified: true,
  ),
  ServiceProvider(
    name: "Amit Singh",
    service: "Driver / Cab",
    imageUrl: "https://i.imgur.com/bNEy55y.png",
    rating: 4.7,
    jobsDone: 300,
  ),
];