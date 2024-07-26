class Account {
  int balance;

  Account({required this.balance});

  Account copyWith({int? balance}) {
    return Account(
      balance: balance ?? this.balance,
    );
  }
}

class ATM {
  Map<int, int> availableNotes;

  ATM({required this.availableNotes});

  bool canWithdraw(int amount, int balance) {
    if(balance < amount) return false;
    int remainingAmount = amount;
    Map<int, int> requiredNotes = {};

    availableNotes.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key))
      ..forEach((entry) {
        int note = entry.key;
        int count = entry.value;
        int required = (remainingAmount / note).floor();
        if (required > 0) {
          requiredNotes[note] = required > count ? count : required;
          remainingAmount -= note * requiredNotes[note]!;
        }
      });

    return remainingAmount == 0;
  }

  Map<int, int> withdraw(int amount) {
    int remainingAmount = amount;
    Map<int, int> notesToGive = {};

    availableNotes.entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key))
      ..forEach((entry) {
        int note = entry.key;
        int count = entry.value;
        int required = (remainingAmount / note).floor();
        if (required > 0) {
          notesToGive[note] = required > count ? count : required;
          remainingAmount -= note * notesToGive[note]!;
          availableNotes[note] = availableNotes[note]! - notesToGive[note]!;
        }
      });

    return notesToGive;
  }


  ATM copyWith({Map<int, int>? availableNotes}) {
    return ATM(
      availableNotes: availableNotes ?? this.availableNotes,
    );
  }
}
