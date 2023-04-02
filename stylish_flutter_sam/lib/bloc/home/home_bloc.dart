import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:stylish_flutter_sam/data/HomeItem.dart';
import 'package:stylish_flutter_sam/repo/StylishRepository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StylishRepository _repository;

  HomeBloc(this._repository) : super(HomeInitial()) {
    on<HomeLoadEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        var datum = await _repository.getHomeDatum();
        emit(HomeSuccessState(datum));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    });
  }
}
