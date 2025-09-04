import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rewarity/app/app.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RewarityApp());

    // For now just verify a widget exists, e.g. title or text in Dashboard
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
