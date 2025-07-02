import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_tour_booking_app/presentation/home_page/cubit/home_page_cubit.dart';
import 'package:mini_tour_booking_app/presentation/home_page/cubit/home_page_states.dart';
import 'package:mini_tour_booking_app/presentation/my_booking_page/my_booking_page.dart';
import 'package:mini_tour_booking_app/presentation/resourses/media_query_values.dart';
import 'package:mini_tour_booking_app/presentation/tour_details_page/tour_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tours Booking App'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBookingsPage()),
            );
          },
          icon: Icon(Icons.event_available),
        ),
      ),
      body: BlocBuilder<HomePageCubit, TourState>(
        builder: (context, state) {
          if (state is TourLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TourLoaded) {
            final tours = state.tours;
            return ListView.builder(
              itemCount: tours.length,
              itemBuilder: (context, index) {
                final tour = tours[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TourDetailsPage(tour: tour),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              tour.image!,
                              height: context.height * 0.24,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tour.title ?? '',
                                  style: TextStyle(
                                    fontSize: context.height * 0.022,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tour.desc ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: context.height * 0.018,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tour.price ?? '',
                                  style: TextStyle(
                                    fontSize: context.height * 0.02,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TourError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
