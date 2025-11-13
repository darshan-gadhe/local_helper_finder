import 'package:flutter/material.dart';
import 'package:locallinker/models/service_provider_model.dart';
import 'package:locallinker/screens/helper_details_screen.dart';

class HelperCard extends StatelessWidget {
  final ServiceProvider provider;
  const HelperCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HelperDetailsScreen(helper: provider)),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(provider.imageUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          provider.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        if (provider.isVerified)
                          const Padding(
                            padding: EdgeInsets.only(left: 6.0),
                            child: Icon(Icons.verified, color: Colors.blue, size: 18),
                          ),
                      ],
                    ),
                    Text(
                      provider.service,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          "${provider.rating} (${provider.jobsDone}+ reviews)",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // --- NEW PRICE DISPLAY SECTION ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$${provider.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    provider.priceType,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              // --- END NEW SECTION ---

            ],
          ),
        ),
      ),
    );
  }
}