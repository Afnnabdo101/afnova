import 'package:afnova/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the AFNOVA prototype and its illustrated guide',
      (tester) async {
    await tester.pumpWidget(const AfnovaApp());

    expect(find.text('AFNOVA'), findsOneWidget);
    expect(find.text('ملفاتك.\nمن جهاز لجهاز.'), findsOneWidget);
    expect(find.text('اختر ملفات'), findsOneWidget);
    final scrollable = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(
      find.text('ميزات في خارطة الطريق'),
      300,
      scrollable: scrollable,
    );
    expect(find.text('ميزات في خارطة الطريق'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('دليل AFNOVA المصوّر'),
      300,
      scrollable: scrollable,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('دليل AFNOVA المصوّر'));
    await tester.pumpAndSettle();

    expect(find.text('فكرة AFNOVA'), findsOneWidget);
    expect(find.text('1 / 4'), findsOneWidget);

    await tester.tap(find.text('التالي'));
    await tester.pumpAndSettle();
    expect(find.text('كيف يعمل النقل؟'), findsOneWidget);
    expect(find.text('2 / 4'), findsOneWidget);
  });
}
