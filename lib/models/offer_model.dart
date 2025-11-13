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
    // <-- NEW IMAGE URL -->
    imageUrl: "https://images.unsplash.com/photo-1562887189-e5d8881f7464?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
  ),
  Offer(
    title: "House Painting Special",
    description: "Get a free quote and 15% off",
    // <-- NEW IMAGE URL -->
    imageUrl: "https://images.unsplash.com/photo-1600826194695-3579c1faf343?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
  ),
  Offer(
    title: "AC Service & Repair",
    description: "Starts at just \$20",
    // <-- NEW IMAGE URL -->
    imageUrl: "https://images.unsplash.com/photo-1634595261176-2a42a1744e43?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1696&q=80",
  ),
];