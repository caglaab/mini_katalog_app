import 'package:flutter/material.dart';

import '../data/cart_state.dart';

/// Sağ üstteki sepet ikonu. Üzerinde sepetteki ürün adedi rozet olarak görünür.
class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<CartItem>>(
      valueListenable: CartState.instance.items,
      builder: (context, items, _) {
        final count = items.fold<int>(0, (sum, item) => sum + item.quantity);

        return IconButton(
          onPressed: () => Navigator.pushNamed(context, '/cart'),
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
        );
      },
    );
  }
}
