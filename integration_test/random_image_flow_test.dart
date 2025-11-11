import 'package:aurora_info_session/main.dart' as app;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Random image flow', () {
    testWidgets('loads image, refreshes, bookmarks, and navigates',
        (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(CachedNetworkImage), findsOneWidget);

      final refreshButton = find.text('Another');
      expect(refreshButton, findsOneWidget);

      for (var i = 0; i < 4; i++) {
        await tester.tap(refreshButton);
        await tester.pumpAndSettle();
        expect(find.byType(CachedNetworkImage), findsOneWidget);
         await tester.pump(const Duration(seconds: 1));
      }

      final bookmarkToggle = find.byTooltip('Add bookmark');
      expect(bookmarkToggle, findsOneWidget);
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(bookmarkToggle);
      await tester.pumpAndSettle(const Duration(milliseconds: 600));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byTooltip('Remove bookmark'), findsOneWidget);

      final openAlbumButton = find.byTooltip('Open markbook album');
      expect(openAlbumButton, findsOneWidget);
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(openAlbumButton);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('Bookmarks'), findsOneWidget);
      expect(find.text('No marked images yet.'), findsNothing);

      final bookmarkGrid = find.byType(GridView);
      expect(bookmarkGrid, findsOneWidget);

      final bookmarkTile = find.descendant(
        of: bookmarkGrid,
        matching: find.byType(GestureDetector),
      ).first;
      await tester.tap(bookmarkTile);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 2));

      expect(find.text('Image Detail'), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Bookmarks'), findsOneWidget);
    });
  });
}
