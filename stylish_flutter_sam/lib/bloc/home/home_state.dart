part of 'home_bloc.dart';

abstract class HomeState {
  HomeState();
}

class HomeInitial extends HomeState {
  HomeInitial() : super();
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super();
}

class HomeSuccessState extends HomeState {
  List<HomeProduct>? womenDatum;
  List<HomeProduct>? menDatum;
  List<HomeProduct>? accessoriesDatum;
  List<HomeProduct>? hotsDatum;

  HomeSuccessState({
    required this.womenDatum,
    required this.menDatum,
    required this.accessoriesDatum,
    required this.hotsDatum,
  }) : super();
}

class HomeErrorState extends HomeState {
  String errorMsg = "";

  HomeErrorState(this.errorMsg) : super();
}
