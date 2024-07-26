import 'package:atm_wip/atm/models.dart';
import 'package:atm_wip/atm/providers.dart';
import 'package:atm_wip/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ATM Widget Test', (WidgetTester tester) async {
    final account = Account(balance: 2000);
    final atm = ATM(availableNotes: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountProvider.overrideWith((ref) => AccountNotifier(account)),
          atmProvider.overrideWith((ref) => ATMNotifier(atm)),
        ],
        child: const ATMApp(),
      ),
    );

    expect(find.text('Balance: 2000 zł'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '380');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Withdrawn: 1 x 200zł, 1 x 100zł, 1 x 50zł, 1 x 20zł, 1 x 10zł'), findsOneWidget);
    expect(find.text('Balance: 1620 zł'), findsOneWidget);
  });

  testWidgets('Cannot withdraw more than balance', (WidgetTester tester) async {
    final account = Account(balance: 2000);
    final atm = ATM(availableNotes: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountProvider.overrideWith((ref) => AccountNotifier(account)),
          atmProvider.overrideWith((ref) => ATMNotifier(atm)),
        ],
        child: const ATMApp(),
      ),
    );

    await tester.enterText(find.byType(TextField), '2500');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Cannot withdraw this amount.'), findsOneWidget);
  });

  testWidgets('Cannot withdraw invalid amount', (WidgetTester tester) async {
    final account = Account(balance: 2000);
    final atm = ATM(availableNotes: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountProvider.overrideWith((ref) => AccountNotifier(account)),
          atmProvider.overrideWith((ref) => ATMNotifier(atm)),
        ],
        child: const ATMApp(),
      ),
    );

    await tester.enterText(find.byType(TextField), '-100');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Cannot withdraw this amount.'), findsOneWidget);
  });
}
