import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter_sam/bloc/Home/home_bloc.dart';
import 'package:stylish_flutter_sam/bloc/content/product_content_bloc.dart';
import 'package:stylish_flutter_sam/dataprovider/repo/stylish_repository.dart';
import 'package:stylish_flutter_sam/view/home_page.dart';

import 'util/my_custom_scroll_behavior.dart';

void main() {
  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    StylishRepository repository = StylishRepository();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc(repository)..add(HomeLoadEvent()),
          ),
          BlocProvider(
            create: (_) => ProductContentBloc(repository),
          ),
        ],
        child: MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          home: const HomePage(),
        ));
  }
}
