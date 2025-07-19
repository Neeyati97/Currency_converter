import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_converter/main.dart';

void main() {
  testWidgets('CurrencyConverter UI test', (WidgetTester tester) async {
    await tester.pumpWidget(CurrencyConverter());

    // Check for input field
    expect(find.byType(TextField), findsOneWidget);

    // Check for button
    expect(find.text('Convert to INR'), findsOneWidget);

    // Enter sample input
    await tester.enterText(find.byType(TextField), '10');

    // Tap convert button
    await tester.tap(find.text('Convert to INR'));
    await tester.pump(); // rebuild UI after setState()

    // We skip API mocking here; this verifies basic structure
  });
}
