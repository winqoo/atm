import 'package:atm_wip/atm/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountProvider = StateNotifierProvider<AccountNotifier, Account>((ref) {
  return AccountNotifier(Account(balance: 2000));
});

class AccountNotifier extends StateNotifier<Account> {
  AccountNotifier(super.state);

  void updateBalance(int newBalance) {
    state = state.copyWith(balance: newBalance);
  }
}

final atmProvider = StateNotifierProvider<ATMNotifier, ATM>((ref) {
  return ATMNotifier(ATM(
    availableNotes: {50: 40, 20: 60, 10: 100},
  )); // Example notes
});

class ATMNotifier extends StateNotifier<ATM> {
  ATMNotifier(super.state);

  void withdrawAmount(int amount) {
    state = state.copyWith(availableNotes: state.availableNotes);
  }
}
