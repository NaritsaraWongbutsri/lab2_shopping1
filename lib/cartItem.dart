import 'package:flutter/material.dart';
import 'package:lab2_shopping/item.dart';

class CartItem extends StatefulWidget {
  Item items;
  final Function(int) updateTotal;

  CartItem({super.key, required this.items, required this.updateTotal});

  @override
  State<CartItem> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.items.amount;
  }

  void updateAmount(int amount) {
    setState(() {
      quantity = amount;
    });
  }

  Function(int) get updateTotal => widget.updateTotal;

  void clearItem() {
    setState(() {
      quantity = 0;
    });
    updateTotal(0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: ${widget.items.price}',
              style: Theme.of(context).textTheme.labelSmall,
            )
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (quantity > 0) {
                    quantity--;
                    widget.updateTotal(-widget.items.price.toInt());
                  }
                });
              },
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                });
                widget.updateTotal(widget.items.price.toInt());
              },
            ),
          ],
        ),
      ],
    );
  }
}
