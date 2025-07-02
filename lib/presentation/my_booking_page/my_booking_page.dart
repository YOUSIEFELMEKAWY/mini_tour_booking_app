import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_tour_booking_app/presentation/booking_page/cubit/booking_page_cubit.dart';
import 'package:mini_tour_booking_app/presentation/booking_page/cubit/booking_page_states.dart';
import 'package:mini_tour_booking_app/presentation/resourses/media_query_values.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<BookingPageCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings'), centerTitle: true),
      body: BlocBuilder<BookingPageCubit, BookingPageStates>(
        builder: (context, state) {
          final tours = cubit.savedTours;

          if (tours.isEmpty) {
            return const Center(child: Text('There are no bookings yet.'));
          }

          return ListView.builder(
            itemCount: tours.length,
            itemBuilder: (context, index) {
              final tour = tours[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  leading: Image.network(
                    tour['img'],
                    width: context.width * 0.15,
                    height: context.width * 0.15,
                    fit: BoxFit.cover,
                  ),
                  title: Text(tour['title']),
                  subtitle: Text(tour['price']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      cubit.deleteDate(id: tour['id']);
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Deleted')));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
