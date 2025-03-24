import 'package:flutter/material.dart';
import 'package:lab2_shopping/cartItem.dart';
import 'package:lab2_shopping/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15', price: 1500),
    Item(name: 'MacBook Pro', price: 2500),
    Item(name: 'iPad Pro', price: 10000),
  ];

  List<GlobalKey<CartItemState>> cartItemKeys = [];
  List<CartItem> cartItems = <CartItem>[];

  int total = 0;

  void updateTotal(int price) {
    setState(() {
      total += price;
    });
  }

  void clearCart() {
    setState(() {
      total = 0;
      for (var key in cartItemKeys) {
        key.currentState?.clearItem();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    for (Item item in items) {
      final key = GlobalKey<CartItemState>();
      cartItems.add(CartItem(key: key, items: item, updateTotal: updateTotal));
      cartItemKeys.add(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Cart',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      clearCart();
                    },
                    label: const Text('Clear Cart'),
                    icon: const Icon(Icons.clear)),
              ],
            ),
            for (CartItem cartItem in cartItems) cartItem,
            Expanded(
              child: Container(),
            ),
            Container(
                width: double.infinity,
                height: 100,
                color: Colors.grey[200],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:'),
                    Text('$total ฿',
                        style: Theme.of(context).textTheme.headlineLarge),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
