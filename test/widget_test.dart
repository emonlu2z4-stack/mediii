import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicare/main.dart';

void main() {
  testWidgets('App loads home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MediCareApp());
    await tester.pumpAndSettle();
    expect(find.textContaining('Hello'), findsOneWidget);
  });
}
