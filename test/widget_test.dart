import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kanban/ui/main_app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MainApp()));

    // Verify that the app title or some element exists.
    // MainApp sets title 'Kanbellon', but that's not a widget.
    // We can look for HomeScreen content? 
    // HomeScreen might show specific text.
    // But mostly just checking it pumps without crashing is enough for smoke test.
    await tester.pumpAndSettle();
    
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
