import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_tour_booking_app/presentation/booking_page/cubit/booking_page_cubit.dart';
import 'package:mini_tour_booking_app/presentation/resourses/media_query_values.dart';

class BookingPage extends StatelessWidget {
  final String title;
  final String desc;
  final String img;
  final String price;

  BookingPage({
    super.key,
    required this.title,
    required this.desc,
    required this.img,
    required this.price,
  });

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final travelersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<BookingPageCubit>(context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Book Your Tour'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'User Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: travelersController,
                decoration: const InputDecoration(
                  labelText: 'Number of travelers',
                ),
                keyboardType: TextInputType.number,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<BookingPageCubit>(context).insertToDatabase(
                      title: title,
                      desc: desc,
                      img: img,
                      price: price,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booked successfully')),
                    );

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      fontSize: context.height * 0.025,
                      color: Colors.black,
                    ),
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
