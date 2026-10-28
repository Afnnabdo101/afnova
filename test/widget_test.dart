import 'package:afnova/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the AFNOVA home screen in Arabic', (tester) async {
    await tester.pumpWidget(const AfnovaApp());

    expect(find.text('AFNOVA'), findsOneWidget);
    expect(find.text('ملفاتك.\nبلا حدود.'), findsOneWidget);
    expect(find.text('اختر ملفات للإرسال'), findsOneWidget);
  });
}
