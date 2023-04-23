import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:stylish_flutter_sam/data/HomeItem.dart';
import 'package:stylish_flutter_sam/dataprovider/repo/stylish_repository.dart';
import '../../data/ProductsDatum.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StylishRepository _repository;

  HomeBloc(this._repository) : super(HomeInitial()) {
    on<HomeLoadEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        var response = await Future.wait([
          _repository.getWomenClothes(),
          _repository.getMenClothes(),
          _repository.getAccessories(),
        ]);
        var womenClothes = response[0];
        var menClothes = response[1];
        var accessories = response[2];
        var banners = getBannerClothes(womenClothes, menClothes, accessories);
        emit(HomeSuccessState(
          womenDatum: womenClothes.toHomeProducts(CategoryType.women),
          menDatum: menClothes.toHomeProducts(CategoryType.men),
          accessoriesDatum: accessories.toHomeProducts(CategoryType.accessory),
          hotsDatum: banners,
        ));
      } catch (e) {
        emit(HomeErrorState(e.toString()));
      }
    });
  }

  List<HomeProduct> getBannerClothes(
    ProductsDatum womenApiClothes,
    ProductsDatum menApiClothes,
    ProductsDatum apiAccessories,
  ) {
    var womenClothes = womenApiClothes.toHomeProducts(CategoryType.banner);
    var twoWomenClothes = (womenClothes?.length ?? 0) >= 2
        ? womenClothes?.getRange(0, 2)
        : womenClothes;
    var womenList = twoWomenClothes?.toList() ?? [];

    var menClothes = menApiClothes.toHomeProducts(CategoryType.banner);
    var twoMenClothes = (menClothes?.length ?? 0) >= 2
        ? menClothes?.getRange(0, 2)
        : menClothes;
    var menList = twoMenClothes?.toList() ?? [];

    var accessories = apiAccessories.toHomeProducts(CategoryType.banner);
    var twoAccessories = (accessories?.length ?? 0) >= 2
        ? accessories?.getRange(0, 2)
        : accessories;
    var accessoriesList = twoAccessories?.toList() ?? [];

    return womenList + menList + accessoriesList;
  }
}
