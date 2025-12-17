//import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neuropean/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We need to wrap the App in a ProviderScope because we are using Riverpod.
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Wait for the router to navigate to the initial page
    await tester.pumpAndSettle();

    // Verify that the Test Panel is displayed.
    expect(find.text('Test Panel'), findsOneWidget);
    expect(find.text('Open Chat Interface'), findsOneWidget);
    expect(find.text('Import Character Card'), findsOneWidget);
  });
}
