part of 'home_bloc.dart';

abstract class HomeState {
  HomeDatum? homeDatum;

  HomeState(this.homeDatum);
}

class HomeInitial extends HomeState {
  HomeInitial() : super(null);
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super(null);
}

class HomeSuccessState extends HomeState {
  @override
  HomeDatum? homeDatum;

  HomeSuccessState(this.homeDatum) : super(homeDatum);
}

class HomeErrorState extends HomeState {
  String errorMsg = "";

  HomeErrorState(this.errorMsg) : super(null);
}
