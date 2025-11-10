import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'core/di/service_locator.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  final appRouter = AppRouter();
  final themeCubit = serviceLocator<ThemeCubit>();

  runApp(
    BlocProvider.value(
      value: themeCubit,
      child: App(appRouter: appRouter),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: state.themeMode == ThemeMode.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: state.themeMode,
            routerConfig: appRouter.config(
              navigatorObservers: () => [AutoRouteObserver()],
            ),
          ),
        );
      },
    );
  }
}
