import 'package:flutter/material.dart';
import 'package:locallinker/models/offer_model.dart';
import 'package:locallinker/models/service_category_model.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/widgets/helper_card.dart';
import 'package:locallinker/widgets/offer_card.dart';
import 'package:locallinker/widgets/search_bar_widget.dart';
import 'package:locallinker/widgets/service_category_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // --- Header Section ---
          _buildHeader(),

          // --- Body Section with Padding ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                // --- Search Bar ---
                const SearchBarWidget(hintText: "Search for a service..."),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // --- How it Works Section ---
          _buildHowItWorks(context),
          const SizedBox(height: 24),

          // --- Limited Time Offers ---
          _buildSectionTitle(context, "Limited Time Offers", showViewAll: true),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: limitedTimeOffers.length,
              itemBuilder: (context, index) {
                return OfferCard(offer: limitedTimeOffers[index]);
              },
            ),
          ),
          const SizedBox(height: 24),

          // --- Popular Categories ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildSectionTitle(context, "Popular Categories"),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: serviceCategories.length > 6 ? 6 : serviceCategories.length, // Limit to 6
              itemBuilder: (context, index) {
                return ServiceCategoryIcon(category: serviceCategories[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          ),
          const SizedBox(height: 24),

          // --- Popular Helpers ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                _buildSectionTitle(context, "Popular Helpers", showViewAll: true),
                const SizedBox(height: 16),
                ...popularProviders.map((provider) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: HelperCard(provider: provider),
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: const BoxDecoration(
        color: Color(0xFF0D47A1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Good Morning",
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  Text(
                    "Vaibhav",
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("https://i.imgur.com/L7Le2v1.png"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 16),
              const SizedBox(width: 8),
              const Text("New York, USA", style: TextStyle(color: Colors.white70)),
              const Icon(Icons.arrow_drop_down, color: Colors.white70),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorks(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("How Locallinker Works", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStep(icon: Icons.search, title: "Search", subtitle: "Find your expert"),
              _buildStep(icon: Icons.calendar_today, title: "Book", subtitle: "Schedule a time"),
              _buildStep(icon: Icons.replay, title: "Relax", subtitle: "Job gets done"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep({required IconData icon, required String title, required String subtitle}) {
    // A custom icon for 'relax'
    final IconData relaxIcon = const IconData(0xea8b, fontFamily: 'MaterialIcons');
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black26,
          child: Icon(icon == Icons.replay ? relaxIcon : icon, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, {bool showViewAll = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        if (showViewAll)
          TextButton(
            onPressed: () {},
            child: const Text("View All"),
          ),
      ],
    );
  }
}