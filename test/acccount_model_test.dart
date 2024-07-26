import 'package:atm_wip/atm/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Account Model', () {
    test('Initial balance is correct', () {
      final account = Account(balance: 2000);
      expect(account.balance, 2000);
    });

    test('Balance is reduced after withdrawal', () {
      final account = Account(balance: 2000);
      account.balance -= 500;
      expect(account.balance, 1500);
    });
  });
}
