import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/Home/home_bloc.dart';
import 'package:stylish_flutter_sam/repo/StylishRepository.dart';
import 'package:stylish_flutter_sam/view/HomePage.dart';

import 'util/MyCustomScrollBehavior.dart';

void main() {
  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    StylishRepository _repository = StylishRepository();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc(_repository)..add(HomeLoadEvent()),
          ),
        ],
        child: MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          home: const HomePage(),
        ));
  }
}
