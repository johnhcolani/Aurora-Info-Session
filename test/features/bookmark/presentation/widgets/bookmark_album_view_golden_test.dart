import 'package:aurora_info_session/core/di/service_locator.dart';
import 'package:aurora_info_session/features/bookmark/domain/entities/bookmark_entity.dart';
import 'package:aurora_info_session/features/bookmark/presentation/cubit/bookmark_album_cubit.dart';
import 'package:aurora_info_session/features/bookmark/presentation/screens/bookmark_album_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

/// Mock cubit for testing bookmark album functionality.
class _MockBookmarkAlbumCubit extends Mock implements BookmarkAlbumCubit {}

/// Golden tests for the bookmark album view, verifying visual appearance matches expected screenshots.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await loadAppFonts();
  });

  group('BookmarkAlbum golden tests', () {
    late BookmarkAlbumCubit cubit;

    setUp(() {
      cubit = _MockBookmarkAlbumCubit();
      if (serviceLocator.isRegistered<BookmarkAlbumCubit>()) {
        serviceLocator.unregister<BookmarkAlbumCubit>();
      }
      serviceLocator.registerFactory<BookmarkAlbumCubit>(() => cubit);
      when(() => cubit.close()).thenAnswer((_) async {});
      when(() => cubit.loadBookmarks()).thenAnswer((_) async {});
    });

    tearDown(() async {
      if (serviceLocator.isRegistered<BookmarkAlbumCubit>()) {
        serviceLocator.unregister<BookmarkAlbumCubit>();
      }
      await cubit.close();
    });

    /// Tests that the bookmark album displays correctly when it contains bookmarked images.
    testGoldens('renders bookmark album with content', (tester) async {
      final state = BookmarkAlbumState(
        isLoading: false,
        bookmarks: [
          BookmarkEntity(
            id: 1,
            url: 'https://example.com/a.jpg',
            createdAt: DateTime(2024, 1, 1),
          ),
          BookmarkEntity(
            id: 2,
            url: 'https://example.com/b.jpg',
            createdAt: DateTime(2024, 2, 1),
          ),
        ],
      );
      when(() => cubit.state).thenReturn(state);
      when(() => cubit.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: BookmarkAlbumPage(),
        ),
      );
      await screenMatchesGolden(
        tester,
        'bookmark_album_populated',
      );
    });

    /// Tests that the bookmark album displays the empty state correctly when no bookmarks exist.
    testGoldens('renders empty bookmark album', (tester) async {
      const state = BookmarkAlbumState(isLoading: false);
      when(() => cubit.state).thenReturn(state);
      when(() => cubit.stream).thenAnswer((_) => Stream.value(state));

      await tester.pumpWidgetBuilder(
        const MaterialApp(
          home: BookmarkAlbumPage(),
        ),
      );
      await screenMatchesGolden(
        tester,
        'bookmark_album_empty',
      );
    });
  });
}
