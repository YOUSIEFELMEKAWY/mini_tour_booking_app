import 'package:mini_tour_booking_app/domain/tour_model.dart';

abstract class TourState {}

class TourInitial extends TourState {}

class TourLoading extends TourState {}

class TourLoaded extends TourState {
  final List<TourModel> tours;
  TourLoaded(this.tours);
}

class TourError extends TourState {
  final String message;
  TourError(this.message);
}
