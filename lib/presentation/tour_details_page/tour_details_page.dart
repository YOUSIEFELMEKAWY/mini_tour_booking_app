import 'package:flutter/material.dart';
import 'package:mini_tour_booking_app/domain/tour_model.dart';
import 'package:mini_tour_booking_app/presentation/booking_page/booking_page.dart';
import 'package:mini_tour_booking_app/presentation/resourses/media_query_values.dart';

class TourDetailsPage extends StatelessWidget {
  final TourModel tour;

  const TourDetailsPage({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tour.title ?? 'Details'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              tour.image!,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.35,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tour.title ?? '',
                    style: TextStyle(
                      fontSize: context.width * 0.065,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    tour.price ?? '',
                    style: TextStyle(
                      fontSize: context.width * 0.05,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    tour.desc ?? '',
                    style: TextStyle(fontSize: context.width * 0.042),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: context.height * 0.05,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    title: tour.title!,
                    desc: tour.desc!,
                    img: tour.image!,
                    price: tour.price!,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Book Now',
              style: TextStyle(
                fontSize: context.height * 0.025,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
