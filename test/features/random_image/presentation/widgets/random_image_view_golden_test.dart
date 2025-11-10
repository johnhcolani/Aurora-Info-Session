import 'package:aurora_info_session/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:aurora_info_session/features/random_image/presentation/widgets/random_image_view.dart';
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

    testGoldens('renders failure state layout', (tester) async {
      const failureState = RandomImageState(
        status: RandomImageStatus.failure,
        errorMessage: 'Unable to load image.',
      );

      when(() => bloc.state).thenReturn(failureState);
      whenListen(
        bloc,
        Stream<RandomImageState>.value(failureState),
        initialState: failureState,
      );

      await tester.pumpWidgetBuilder(
        BlocProvider<RandomImageBloc>.value(
          value: bloc,
          child: const RandomImageView(),
        ),
        wrapper: materialAppWrapper(
          theme: ThemeData.light(),
        ),
        surfaceSize: const Size(390, 844),
      );

      await screenMatchesGolden(
        tester,
        'random_image_view_failure_state',
      );
    });
  });
}

