part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitState extends HomeState {}

class HomeLoadedState extends HomeState {
  final WeatherModel weatherModel;

  HomeLoadedState({required this.weatherModel});
}

class HomeLoadingState extends HomeState {}

class HomeFailureState extends HomeState {
  final String message;

  HomeFailureState({required this.message});
}
