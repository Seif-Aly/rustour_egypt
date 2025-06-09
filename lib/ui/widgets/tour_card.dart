import 'package:flutter/material.dart';
import '../../models/tour.dart';
import '../pages/tour_details_page.dart'; // ← NEW import

class TourCard extends StatelessWidget {
  const TourCard({super.key, required this.tour});
  final Tour tour;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // ← wrap with InkWell
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TourDetailsPage(tour: tour),
            ), // ← open details
          ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: 160,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Image.network(
                  tour.imageUrl,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tour.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text('от \$${tour.pricePerAdult}'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
