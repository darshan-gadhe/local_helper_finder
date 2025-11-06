class StoreBrand {
  final String name;
  final String logoUrl;
  final int productCount;
  final List<String> sampleProductImageUrls; // URLs for the small preview images

  StoreBrand({
    required this.name,
    required this.logoUrl,
    required this.productCount,
    required this.sampleProductImageUrls,
  });
}

// Dummy Data for demonstration
final List<StoreBrand> featuredBrands = [
  StoreBrand(
      name: "Pro Tools",
      logoUrl: "https://i.imgur.com/S2gL4aW.png", // Generic logo
      productCount: 172,
      sampleProductImageUrls: [
        "https://i.imgur.com/8aV4aYp.png", // Drill
        "https://i.imgur.com/gK2t2dI.png", // Wrench set
        "https://i.imgur.com/L79Qn1i.png", // Toolbag
      ]),
  StoreBrand(
      name: "Paint Masters",
      logoUrl: "https://i.imgur.com/wVqj9aE.png", // Generic logo
      productCount: 85,
      sampleProductImageUrls: [
        "https://i.imgur.com/i9TzT7N.png", // Paint roller
        "https://i.imgur.com/h5T2uW5.png", // Paint can
        "https://i.imgur.com/4hV5p6y.png", // Brushes
      ]),
  StoreBrand(
      name: "Safety First",
      logoUrl: "https://i.imgur.com/j1y5L7g.png", // Generic logo
      productCount: 110,
      sampleProductImageUrls: [
        "https://i.imgur.com/yL6K0Ua.png", // Hard hat
        "https://i.imgur.com/R3a0f5Q.png", // Safety glasses
        "https://i.imgur.com/Z8vX1hT.png", // Gloves
      ]),
];