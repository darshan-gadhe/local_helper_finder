class StoreBrand {
  final String name;
  final String logoUrl;
  final int productCount;
  final List<String> sampleProductImageUrls;

  StoreBrand({
    required this.name,
    required this.logoUrl,
    required this.productCount,
    required this.sampleProductImageUrls,
  });
}

final List<StoreBrand> featuredBrands = [
  StoreBrand(
      name: "Pro Tools",
      // <-- NEW IMAGE URL (Logo) -->
      logoUrl: "https://images.unsplash.com/photo-1556912173-356a54274d87?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=880&q=80",
      productCount: 172,
      sampleProductImageUrls: [
        // <-- NEW IMAGE URLs (Products) -->
        "https://images.unsplash.com/photo-1627012574169-4d87400508cf?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
        "https://images.unsplash.com/photo-1618995965932-2591d3745582?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
        "https://images.unsplash.com/photo-1590204603912-212da6d38e34?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
      ]),
  StoreBrand(
      name: "Paint Masters",
      // <-- NEW IMAGE URL (Logo) -->
      logoUrl: "https://images.unsplash.com/photo-1531835551805-16d864c8d311?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
      productCount: 85,
      sampleProductImageUrls: [
        // <-- NEW IMAGE URLs (Products) -->
        "https://images.unsplash.com/photo-1579762715454-d90d011b659d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
        "https://images.unsplash.com/photo-1605310221332-243f961628af?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1740&q=80",
        "https://images.unsplash.com/photo-1579762593175-202741340203?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=774&q=80",
      ]),
];