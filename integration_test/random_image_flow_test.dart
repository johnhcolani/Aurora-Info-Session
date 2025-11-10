import 'package:aurora_info_session/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Random image flow', () {
    testWidgets('loads image and refreshes with loading indicator',
        (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.byType(CachedNetworkImage), findsOneWidget);

      final refreshButton = find.text('Another');
      expect(refreshButton, findsOneWidget);

      await tester.tap(refreshButton);
      await tester.pumpAndSettle();

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });
  });
}
