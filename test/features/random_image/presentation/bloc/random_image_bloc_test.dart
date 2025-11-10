import 'dart:ui';

import 'package:aurora_info_session/core/resources/data_state.dart';
import 'package:aurora_info_session/core/usecase/use_case.dart';
import 'package:aurora_info_session/features/bookmark/domain/usecases/add_bookmark_usecase.dart';
import 'package:aurora_info_session/features/bookmark/domain/usecases/is_bookmarked_usecase.dart';
import 'package:aurora_info_session/features/bookmark/domain/usecases/remove_bookmark_usecase.dart';
import 'package:aurora_info_session/features/random_image/domain/entities/random_image_entity.dart';
import 'package:aurora_info_session/features/random_image/domain/usecases/get_random_image_usecase.dart';
import 'package:aurora_info_session/features/random_image/presentation/bloc/random_image_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetRandomImageUseCase extends Mock
    implements GetRandomImageUseCase {}

class _MockAddBookmarkUseCase extends Mock implements AddBookmarkUseCase {}

class _MockRemoveBookmarkUseCase extends Mock
    implements RemoveBookmarkUseCase {}

class _MockIsBookmarkedUseCase extends Mock implements IsBookmarkedUseCase {}

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
    late _MockAddBookmarkUseCase addBookmarkUseCase;
    late _MockRemoveBookmarkUseCase removeBookmarkUseCase;
    late _MockIsBookmarkedUseCase isBookmarkedUseCase;

    setUp(() {
      getRandomImageUseCase = _MockGetRandomImageUseCase();
      addBookmarkUseCase = _MockAddBookmarkUseCase();
      removeBookmarkUseCase = _MockRemoveBookmarkUseCase();
      isBookmarkedUseCase = _MockIsBookmarkedUseCase();
    });

    blocTest<RandomImageBloc, RandomImageState>(
      'emits loading then success when image is fetched',
      build: () {
        when(() => getRandomImageUseCase.call(any())).thenAnswer(
          (_) async => const DataSuccess<RandomImageEntity>(testEntity),
        );
        when(() => isBookmarkedUseCase.call(any()))
            .thenAnswer((_) async => false);

        return RandomImageBloc(
          getRandomImageUseCase,
          addBookmarkUseCase: addBookmarkUseCase,
          removeBookmarkUseCase: removeBookmarkUseCase,
          isBookmarkedUseCase: isBookmarkedUseCase,
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
          addBookmarkUseCase: addBookmarkUseCase,
          removeBookmarkUseCase: removeBookmarkUseCase,
          isBookmarkedUseCase: isBookmarkedUseCase,
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

    blocTest<RandomImageBloc, RandomImageState>(
      'toggles bookmark when bookmark button pressed',
      build: () {
        when(() => getRandomImageUseCase.call(any())).thenAnswer(
          (_) async => const DataSuccess<RandomImageEntity>(testEntity),
        );
        when(() => isBookmarkedUseCase.call(any()))
            .thenAnswer((_) async => false);
        when(() => addBookmarkUseCase.call(any()))
            .thenAnswer((_) async => Future<void>.value());

        return RandomImageBloc(
          getRandomImageUseCase,
          addBookmarkUseCase: addBookmarkUseCase,
          removeBookmarkUseCase: removeBookmarkUseCase,
          isBookmarkedUseCase: isBookmarkedUseCase,
          loadDominantColor: (_) async => dominantColor,
        );
      },
      act: (bloc) async {
        bloc.add(const RandomImageEvent.started());
        await Future<void>.delayed(Duration.zero);
        bloc.add(const RandomImageEvent.bookmarkToggled());
      },
      expect: () => [
        const RandomImageState(status: RandomImageStatus.loading),
        const RandomImageState(
          status: RandomImageStatus.success,
          image: testEntity,
          backgroundColor: dominantColor,
        ),
        const RandomImageState(
          status: RandomImageStatus.success,
          image: testEntity,
          backgroundColor: dominantColor,
          isBookmarked: true,
        ),
      ],
    );
  });
}

