import 'dart:ui';

import 'package:aurora_info_session/core/resources/data_state.dart';
import 'package:aurora_info_session/core/usecase/use_case.dart';
import 'package:aurora_info_session/features/random_image/domain/entities/random_image_entity.dart';
import 'package:aurora_info_session/features/random_image/domain/usecases/get_random_image_usecase.dart';
import 'package:aurora_info_session/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetRandomImageUseCase extends Mock
    implements GetRandomImageUseCase {}

class _FakeNoParams extends Fake implements NoParams {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeNoParams());
  });

  group('RandomImageBloc', () {
    const testEntity = RandomImageEntity(
      url: 'https://example.com/image.jpg',
    );
    const dominantColor = Color(0xFF336699);

    late _MockGetRandomImageUseCase getRandomImageUseCase;

    setUp(() {
      getRandomImageUseCase = _MockGetRandomImageUseCase();
    });

    blocTest<RandomImageBloc, RandomImageState>(
      'emits loading then success when image is fetched',
      build: () {
        when(() => getRandomImageUseCase.call(any()))
            .thenAnswer((_) async => const DataSuccess<RandomImageEntity>(
                  testEntity,
                ));

        return RandomImageBloc(
          getRandomImageUseCase,
          loadDominantColor: (_) async => dominantColor,
        );
      },
      act: (bloc) => bloc.add(const RandomImageEvent.started()),
      expect: () => const <RandomImageState>[
        RandomImageState(status: RandomImageStatus.loading),
        RandomImageState(
          status: RandomImageStatus.success,
          image: testEntity,
          backgroundColor: dominantColor,
        ),
      ],
      verify: (_) {
        verify(() => getRandomImageUseCase.call(any())).called(1);
      },
    );

    blocTest<RandomImageBloc, RandomImageState>(
      'emits loading then failure when repository returns error',
      build: () {
        when(() => getRandomImageUseCase.call(any()))
            .thenAnswer((_) async => const DataFailed<RandomImageEntity>(
                  'Network error',
                ));

        return RandomImageBloc(
          getRandomImageUseCase,
          loadDominantColor: (_) async => dominantColor,
        );
      },
      act: (bloc) => bloc.add(const RandomImageEvent.refreshRequested()),
      expect: () => const <RandomImageState>[
        RandomImageState(status: RandomImageStatus.loading),
        RandomImageState(
          status: RandomImageStatus.failure,
          errorMessage: 'Network error',
        ),
      ],
      verify: (_) {
        verify(() => getRandomImageUseCase.call(any())).called(1);
      },
    );
  });
}

