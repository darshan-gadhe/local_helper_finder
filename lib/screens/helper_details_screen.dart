import 'package:flutter/material.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/screens/booking_confirmation_screen.dart';

class HelperDetailsScreen extends StatelessWidget {
  final ServiceProvider helper;
  const HelperDetailsScreen({super.key, required this.helper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Allow the header image to extend to the top of the screen
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(helper.imageUrl, height: 280, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(helper.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(helper.service, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
                const SizedBox(height: 16),

                // --- NEW PRICE & RATING ROW ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 8),
                        Text(
                            "${helper.rating} (${helper.jobsDone}+ jobs done)",
                            style: Theme.of(context).textTheme.titleMedium
                        ),
                      ],
                    ),
                    // Price
                    RichText(
                      text: TextSpan(
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: "\$${helper.price.toStringAsFixed(2)}"),
                            TextSpan(
                                text: helper.priceType,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey)
                            ),
                          ]
                      ),
                    )
                  ],
                ),
                // --- END NEW SECTION ---

                const Divider(height: 32),
                Text("About", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                const Text(
                  "Experienced and verified professional with a proven track record of customer satisfaction. Available for immediate booking.",
                  style: TextStyle(fontSize: 16, height: 1.5), // Improved readability
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => BookingConfirmationScreen(helper: helper)));
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                ),
                child: const Text("Book Now", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}