import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_tour_booking_app/data/services/tour_service.dart';
import 'package:mini_tour_booking_app/presentation/home_page/cubit/home_page_states.dart';

class HomePageCubit extends Cubit<TourState> {
  final TourService tourService;

  HomePageCubit(this.tourService) : super(TourInitial()) {
    getTours();
  }
  Future<void> getTours() async {
    emit(TourLoading());
    try {
      final tours = await tourService.getTours();
      emit(TourLoaded(tours));
    } catch (e) {
      emit(TourError('failed'));
    }
  }
}
