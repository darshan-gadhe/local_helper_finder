class ServiceProvider {
  final String name;
  final String service;
  final String imageUrl;
  final double rating;
  final int jobsDone;
  final bool isVerified;
  final double price;       // Price for the service
  final String priceType;   // Unit for the price (e.g., "/hr", "/visit")

  ServiceProvider({
    required this.name,
    required this.service,
    required this.imageUrl,
    required this.rating,
    required this.jobsDone,
    this.isVerified = false,
    required this.price,
    required this.priceType,
  });
}

// Dummy Data for demonstration with a comprehensive list of helpers
final List<ServiceProvider> popularProviders = [
  ServiceProvider(
    name: "Ramesh Kumar",
    service: "Plumber",
    imageUrl: "https://images.unsplash.com/photo-1557862921-37829c790f19?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1742&q=80",
    rating: 4.8,
    jobsDone: 120,
    isVerified: true,
    price: 30.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Sunita Sharma",
    service: "Electrician",
    imageUrl: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
    rating: 4.9,
    jobsDone: 250,
    isVerified: true,
    price: 35.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Amit Singh",
    service: "Driver / Cab",
    imageUrl: "https://images.unsplash.com/photo-1560250097-0b93528c311a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
    rating: 4.7,
    jobsDone: 300,
    price: 20.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Priya Desai",
    service: "Cleaner",
    imageUrl: "https://images.unsplash.com/photo-1581578731548-c64695cc6952?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
    rating: 4.9,
    jobsDone: 410,
    isVerified: true,
    price: 25.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Vikram Rathore",
    service: "Painter",
    imageUrl: "https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
    rating: 4.7,
    jobsDone: 95,
    price: 50.00,
    priceType: "/visit",
  ),
  ServiceProvider(
    name: "Alok Verma",
    service: "Carpenter",
    imageUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
    rating: 4.8,
    jobsDone: 150,
    isVerified: true,
    price: 40.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Karan Joshi",
    service: "Plumber",
    imageUrl: "https://images.unsplash.com/photo-1621905251189-08b45d6a269e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=764&q=80",
    rating: 4.6,
    jobsDone: 88,
    price: 28.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Meera Reddy",
    service: "Cook / Maid",
    imageUrl: "https://images.unsplash.com/photo-1542346764-878564f1416e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
    rating: 4.9,
    jobsDone: 215,
    isVerified: true,
    price: 15.00,
    priceType: "/hr",
  ),
  ServiceProvider(
    name: "Rajesh Gupta",
    service: "Technician",
    imageUrl: "https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
    rating: 4.8,
    jobsDone: 180,
    price: 45.00,
    priceType: "/visit",
  ),
];