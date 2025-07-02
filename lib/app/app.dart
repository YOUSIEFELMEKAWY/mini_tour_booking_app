import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_tour_booking_app/data/services/tour_service.dart';
import 'package:mini_tour_booking_app/presentation/booking_page/cubit/booking_page_cubit.dart';
import 'package:mini_tour_booking_app/presentation/home_page/cubit/home_page_cubit.dart';
import 'package:mini_tour_booking_app/presentation/home_page/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit(TourService())),
        BlocProvider(create: (context) => BookingPageCubit()..createDataBase()),
      ],
      child: const MaterialApp(home: HomePage()),
    );
  }
}
