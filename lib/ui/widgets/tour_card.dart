import 'package:flutter/material.dart';
import '../../models/tour.dart';

class TourCard extends StatelessWidget {
  const TourCard(this.tour, {super.key});
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // preview picture
          Image.network(
            tour.imageUrl,
            width: 120,
            height: 96,
            fit: BoxFit.cover,
            errorBuilder:
                (_, __, ___) =>
                    Container(width: 120, height: 96, color: Colors.grey[300]),
          ),

          // text part
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    tour.title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amberAccent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${tour.ratingValue} (${tour.ratingCount})',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const Spacer(),

                  // price
                  Text(
                    '\$${tour.pricePerAdult.toStringAsFixed(0)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF11b57c),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
