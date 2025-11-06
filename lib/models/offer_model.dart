class Offer {
  final String title;
  final String description;
  final String imageUrl;

  Offer({required this.title, required this.description, required this.imageUrl});
}

final List<Offer> limitedTimeOffers = [
  Offer(
    title: "Monsoon Plumbing Check",
    description: "25% Off on all leakage repairs",
    imageUrl: "https://i.imgur.com/9C2G8yJ.jpeg",
  ),
  Offer(
    title: "House Painting Special",
    description: "Get a free quote and 15% off",
    imageUrl: "https://i.imgur.com/fL8w3sH.jpeg",
  ),
  Offer(
    title: "AC Service & Repair",
    description: "Starts at just \$20",
    imageUrl: "https://i.imgur.com/yU4gB5e.jpeg",
  ),
];