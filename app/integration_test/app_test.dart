import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:app/main.dart' as app;

// Use a global variable to persist the test name between test groups
String testName = '';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Setup User Profile', () {
    testWidgets('Save user name', (WidgetTester tester) async {
      // Start the app
      await app.main();
      await tester.pumpAndSettle();

      // Verify the app loads correctly
      expect(find.text('The Village'), findsOneWidget);
      expect(find.text('Your Name'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      // Initially there might be a circular progress indicator while loading
      await tester.pumpAndSettle(); // Wait for async operations to complete

      // Enter a name in the text field
      testName = 'Test User ${DateTime.now().millisecondsSinceEpoch}';
      await tester.enterText(find.byType(TextField), testName);
      await tester.pumpAndSettle();

      // Verify save button appears
      expect(find.byIcon(Icons.save), findsOneWidget);

      // Tap save button
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Give extra time for network request

      // Verify the save worked (save button should disappear)
      expect(find.byIcon(Icons.save), findsNothing);
      
      // Verify the name is now displayed
      expect(find.text(testName), findsOneWidget);
    });
  });

  group('Verify Profile Persistence', () {
    testWidgets('Name persists after app reload', (WidgetTester tester) async {
      // Start the app again (simulating a fresh app launch)
      await app.main();
      await tester.pumpAndSettle(const Duration(seconds: 3)); // Wait for app to load and data to be fetched

      // Verify the name persisted from the previous test
      expect(find.text(testName), findsOneWidget);
      
      // Verify input field is not in edit mode
      expect(find.byIcon(Icons.save), findsNothing);
    });
  });
}