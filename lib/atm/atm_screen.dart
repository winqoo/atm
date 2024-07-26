import 'package:atm_wip/atm/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ATMScreen extends ConsumerStatefulWidget {
  const ATMScreen({super.key});

  @override
  _ATMScreenState createState() => _ATMScreenState();
}

class _ATMScreenState extends ConsumerState<ATMScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final account = ref.watch(accountProvider);
    final atm = ref.watch(atmProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Balance: ${account.balance} zł'),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Withdrawal Amount'),
          ),
          ElevatedButton(
            onPressed: () {
              int amount = int.tryParse(_controller.text) ?? 0;
              if (amount <= 0 || amount > account.balance || !atm.canWithdraw(amount, account.balance)) {
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    content: Text('Cannot withdraw this amount.'),
                  ),
                );
              } else {
                account.balance -= amount;
                Map<int, int> notes = atm.withdraw(amount);
                ref.read(accountProvider.notifier).updateBalance(account.balance);
                ref.read(atmProvider.notifier).withdrawAmount(amount);

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Withdrawn: ${notes.entries.map((e) => '${e.value} x ${e.key}zł').join(', ')}'),
                  ),
                );
              }
            },
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }
}
