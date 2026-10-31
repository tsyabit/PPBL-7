import 'package:flutter/material.dart';

import '../models/produk.dart';
import 'primary_button.dart';

class CartSummaryBar extends StatelessWidget {
  final int totalItem, totalHarga;
  final VoidCallback onKosongkan;
  const CartSummaryBar({
    super.key,
    required this.totalItem,
    required this.totalHarga,
    required this.onKosongkan,
  });
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 24,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            '$totalItem item • ${rupiah(totalHarga)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          PrimaryButton(
            label: 'Kosongkan',
            icon: Icons.delete_outline,
            onPressed: totalItem == 0 ? null : onKosongkan,
          ),
        ],
      ),
    ),
  );
}
