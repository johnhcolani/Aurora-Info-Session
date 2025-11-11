import 'package:aurora_info_session/features/random_image/domain/entities/random_image_entity.dart';
import 'package:aurora_info_session/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:aurora_info_session/features/random_image/presentation/widgets/random_image_view.dart';
import 'package:aurora_info_session/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

class _MockRandomImageBloc
    extends MockBloc<RandomImageEvent, RandomImageState>
    implements RandomImageBloc {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await loadAppFonts();
  });

  group('RandomImageView golden tests', () {
    late _MockRandomImageBloc bloc;

    setUp(() {
      bloc = _MockRandomImageBloc();
    });

    tearDown(() {
      bloc.close();
    });

    testGoldens('renders success state layout with image', (tester) async {
      const successState = RandomImageState(
        status: RandomImageStatus.success,
        image: RandomImageEntity(
          url: 'https://example.com/image.jpg',
        ),
        backgroundColor: Color(0xFF336699),
      );

      when(() => bloc.state).thenReturn(successState);
      whenListen(
        bloc,
        Stream<RandomImageState>.value(successState),
        initialState: successState,
      );

      await tester.pumpWidgetBuilder(
        MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit()..setTheme(ThemeMode.light),
            ),
            BlocProvider<RandomImageBloc>.value(value: bloc),
          ],
          child: RandomImageView(
            networkImageBuilder: (context, imageUrl, accentColor) {
              return Image.asset(
                'assets/Aurora Text Logo.png',
                fit: BoxFit.cover,
                semanticLabel: 'Aurora logo',
              );
            },
          ),
        ),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(390, 844),
      );

      await screenMatchesGolden(
        tester,
        'random_image_view_success_state',
      );
    });
  });
}

