import 'package:flutter/material.dart';
import 'package:locallinker/models/store_brand_model.dart';
import 'package:locallinker/widgets/search_bar_widget.dart';
import 'package:locallinker/widgets/store_promo_banner.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> storeCategories = [
      "Tools",
      "Materials",
      "Safety Gear",
      "Cleaning",
      "Parts"
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Store", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          const StorePromoBanner(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SearchBarWidget(hintText: "Search in Store"),
          ),
          const SizedBox(height: 24),

          _buildHorizontalSection(
            context,
            title: "Brands",
            itemCount: featuredBrands.length,
            itemBuilder: (context, index) {
              return _buildBrandCard(context, featuredBrands[index]);
            },
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: storeCategories.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return Chip(
                  label: Text(storeCategories[index]),
                  backgroundColor: Theme.of(context).cardColor,
                  labelStyle: const TextStyle(color: Colors.white70),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.separated(
              shrinkWrap: true, // Important for nested list
              physics: const NeverScrollableScrollPhysics(),
              itemCount: featuredBrands.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _buildStoreListCard(context, featuredBrands[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalSection(BuildContext context,
      {required String title,
        required int itemCount,
        required Widget Function(BuildContext, int) itemBuilder}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              TextButton(onPressed: () {}, child: const Text("View All")),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: itemBuilder,
          ),
        )
      ],
    );
  }

  Widget _buildBrandCard(BuildContext context, StoreBrand brand) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(brand.logoUrl),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(brand.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("${brand.productCount} Products",
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStoreListCard(BuildContext context, StoreBrand brand) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(brand.logoUrl),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(brand.name, style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      "${brand.productCount} Products",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: brand.sampleProductImageUrls.map((url) {
                return Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}