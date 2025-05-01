import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

String testName = '';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Setup User Profile', () {
    testWidgets('Save user name', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();

      expect(
        find.text('Create Game'),
        findsOneWidget,
        reason: 'App displays the Create Game button',
      );

      await tester.tap(find.text('Create Game'));
      await tester.pumpAndSettle();

      expect(
        find.text('Your name'),
        findsOneWidget,
        reason: 'App displays the name label',
      );
      expect(
        find.byType(TextField),
        findsOneWidget,
        reason: 'App displays the text field for input',
      );

      await tester.pumpAndSettle();

      testName = 'Test User ${DateTime.now().millisecondsSinceEpoch}';
      await tester.enterText(find.byType(TextField), testName);
      await tester.pumpAndSettle();

      expect(
        find.byIcon(Icons.save),
        findsOneWidget,
        reason: 'Save button appears after text entry',
      );

      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      expect(
        find.byIcon(Icons.save),
        findsNothing,
        reason: 'Save button disappears after saving',
      );
      expect(
        find.text(testName),
        findsOneWidget,
        reason: 'The app displays the entered name',
      );
    });
  });

  group('Verify Profile Persistence', () {
    testWidgets('Name persists after app reload', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();

      expect(
        find.text(testName),
        findsOneWidget,
        reason: 'The name persists across app restarts',
      );
      expect(
        find.byIcon(Icons.save),
        findsNothing,
        reason: 'Input field dont have pending changes',
      );
    });
  });
}
