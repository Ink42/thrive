import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thrive/utils/widgets/wtile.dart';

void main() {
  testWidgets("Wtile with text displays the text", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Wtile(titleText: "text"),
      ),
    ));

    expect(find.text("text"), findsOneWidget);
  });
  testWidgets('Wtile with icon displays the icon', (WidgetTester tester) async {
    const icon = Icons.star;
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Wtile(icon: icon),
      ),
    ));

    final iconFinder = find.byIcon(icon);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Wtile with title displays the title',
      (WidgetTester tester) async {
    const titleText = 'My Title';
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: Wtile(titleText: titleText)),
    ));

    final titleFinder = find.text(titleText);
    expect(titleFinder, findsOneWidget);
  });
}
