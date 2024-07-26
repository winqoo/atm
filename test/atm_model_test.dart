import 'package:atm_wip/atm/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ATM Model', () {
    test('Can withdraw exact amount with available denominations', () {
      final atm = ATM(availableNotes: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10});
      expect(atm.canWithdraw(380, 380), isTrue);
      expect(atm.withdraw(380), {200: 1, 100: 1, 50: 1, 20: 1, 10: 1});
    });

    test('Cannot withdraw more than the available denominations', () {
      final atm = ATM(availableNotes: {200: 0, 100: 0, 50: 0, 20: 0, 10: 8});
      expect(atm.canWithdraw(100, 100), isFalse);
    });

    test('Withdraw reduces the denominations correctly', () {
      final atm = ATM(availableNotes: {200: 2, 100: 2, 50: 2, 20: 2, 10: 2});
      expect(atm.withdraw(380), {200: 1, 100: 1, 50: 1, 20: 1, 10: 1});
      expect(atm.availableNotes, {200: 1, 100: 1, 50: 1, 20: 1, 10: 1});
    });

    test('Cannot withdraw more than account balance', () {
      final account = Account(balance: 500);
      final atm = ATM(availableNotes: {200: 10, 100: 10, 50: 10, 20: 10, 10: 10});
      expect(atm.canWithdraw(600, account.balance), isFalse);
    });
  });
}
