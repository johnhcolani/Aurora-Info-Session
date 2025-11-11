import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../random_image/presentation/bloc/random_image_bloc.dart';
import '../../../random_image/presentation/widgets/random_image_view.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<RandomImageBloc>()..add(const RandomImageEvent.started()),
      child: const RandomImageView(),
    );
  }
}
