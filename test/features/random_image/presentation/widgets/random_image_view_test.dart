import 'package:aurora_info_session/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:aurora_info_session/features/random_image/presentation/widgets/random_image_view.dart';
import 'package:aurora_info_session/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRandomImageBloc
    extends MockBloc<RandomImageEvent, RandomImageState>
    implements RandomImageBloc {}

void main() {
  late _MockRandomImageBloc bloc;
  late ThemeCubit themeCubit;

  setUp(() {
    bloc = _MockRandomImageBloc();
    themeCubit = ThemeCubit()..setTheme(ThemeMode.light);
  });

  tearDown(() {
    bloc.close();
    themeCubit.close();
  });

  testWidgets(
    'shows loading indicator while waiting for image',
    (tester) async {
      const loadingState = RandomImageState(
        status: RandomImageStatus.loading,
      );

      when(() => bloc.state).thenReturn(loadingState);
      whenListen(
        bloc,
        Stream<RandomImageState>.value(loadingState),
        initialState: loadingState,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeCubit>.value(value: themeCubit),
              BlocProvider<RandomImageBloc>.value(value: bloc),
            ],
            child: const RandomImageView(),
          ),
        ),
      );

      expect(find.byType(SpinKitSpinningLines), findsOneWidget);
    },
  );

  testWidgets(
    'renders Aurora logo in the app bar when state is failure',
    (tester) async {
      const state = RandomImageState(
        status: RandomImageStatus.failure,
        errorMessage: 'Something went wrong',
      );

      when(() => bloc.state).thenReturn(state);
      whenListen(
        bloc,
        Stream<RandomImageState>.value(state),
        initialState: state,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<ThemeCubit>.value(value: themeCubit),
              BlocProvider<RandomImageBloc>.value(value: bloc),
            ],
            child: const RandomImageView(),
          ),
        ),
      );

      await tester.pump();

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);

      final imageWidget = tester.widget<Image>(imageFinder);
      expect(imageWidget.semanticLabel, 'Aurora logo');
    },
  );
}

