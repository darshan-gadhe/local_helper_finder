import 'package:flutter/material.dart';
import 'package:locallinker/models/offer_model.dart';
import 'package:locallinker/models/service_category_model.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/providers/location_provider.dart';
import 'package:locallinker/providers/user_provider.dart';
import 'package:locallinker/screens/search_results_screen.dart';
import 'package:locallinker/widgets/helper_card.dart';
import 'package:locallinker/widgets/home_promo_banner.dart';
import 'package:locallinker/widgets/offer_card.dart';
import 'package:locallinker/widgets/service_category_icon.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Navigates to the search results screen when user submits search
  void _onSearchSubmitted(String query) {
    if (query.trim().isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(searchQuery: query.trim()),
        ),
      );
    }
  }

  // Shows a bottom sheet to let the user pick a new location
  void _showLocationPicker(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    // Dummy list of locations for the picker
    final List<String> locations = [
      "New York, USA",
      "London, UK",
      "Tokyo, Japan",
      "Sydney, Australia",
      "Mumbai, India",
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Location",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              // Use ListView.separated for better spacing
              ListView.separated(
                shrinkWrap: true,
                itemCount: locations.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(locations[index]),
                    onTap: () {
                      locationProvider.changeLocation(locations[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Access the providers to get user and location data
    final userProvider = Provider.of<UserProvider>(context);
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      body: ListView(
        children: [
          // Header that displays user name and location
          _buildHeader(context, userProvider, locationProvider),
          const SizedBox(height: 24),

          // Large promotional banner
          const HomePromoBanner(),
          const SizedBox(height: 24),

          // Functional Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for a service...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),
          const SizedBox(height: 24),

          // "How it Works" section
          _buildHowItWorks(context),
          const SizedBox(height: 24),

          // Horizontal list of "Limited Time Offers"
          _buildSectionTitle(context, "Limited Time Offers", showViewAll: true, padding: const EdgeInsets.only(left: 16.0)),
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

          // Horizontal list of "Popular Categories"
          _buildSectionTitle(context, "Popular Categories", padding: const EdgeInsets.symmetric(horizontal: 16.0)),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              itemCount: serviceCategories.length > 6 ? 6 : serviceCategories.length,
              itemBuilder: (context, index) {
                return ServiceCategoryIcon(category: serviceCategories[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(width: 20),
            ),
          ),
          const SizedBox(height: 24),

          // Vertical list of "Popular Helpers"
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

  // --- HELPER WIDGETS ---

  Widget _buildHeader(BuildContext context, UserProvider userProvider, LocationProvider locationProvider) {
    // Get the user's first name from the provider, with a fallback
    final userName = userProvider.user?.name.split(' ')[0] ?? 'User';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
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
                children: [
                  const Text("Welcome Back,", style: TextStyle(fontSize: 16, color: Colors.white70)),
                  Text(
                    userName, // Display the fetched name
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Location setting is now a tappable button
          InkWell(
            onTap: () => _showLocationPicker(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Text(locationProvider.currentLocation, style: const TextStyle(color: Colors.white70)),
                const Icon(Icons.arrow_drop_down, color: Colors.white70),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorks(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text("How Locallinker Works", style: Theme.of(context).textTheme.titleLarge),
          ),
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
    // A custom icon for 'relax' to avoid a potential rendering issue with the 'relax' keyword
    final IconData relaxIcon = const IconData(0xea8b, fontFamily: 'MaterialIcons');

    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Icon(icon == Icons.replay ? relaxIcon : icon, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.7), fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, {bool showViewAll = false, EdgeInsetsGeometry? padding}) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Row(
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
      ),
    );
  }
}