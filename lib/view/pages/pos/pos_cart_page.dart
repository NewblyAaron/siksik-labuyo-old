import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:siksik_labuyo/model/item.dart';

class CartItem {
  final Item item;
  int quantity;

  double subtotal() {
    return item.price * quantity;
  }

  CartItem({required this.item, required this.quantity});
}

class Cart extends ChangeNotifier {
  final List<CartItem> items = List.empty(growable: true);

  double get totalPrice {
    double total = 0;
    for (CartItem ci in items) {
      total += ci.item.price * ci.quantity;
    }
    return total;
  }

  void addItem(CartItem item) {
    for (CartItem ci in items) {
      if (ci.item.id == item.item.id) {
        ci.quantity += item.quantity;
        notifyListeners();
        return;
      }
    }
    
    items.add(item);
    notifyListeners();
  }

  void removeItem(index) {
    items.removeAt(index);
  }

  void removeAll() {
    items.clear();
    notifyListeners();
  }
}

String NO_IMAGE_URL =
    'https://firebasestorage.googleapis.com/v0/b/siksiklabuyo-d9974.appspot.com/o/images%2Fitems%2Fno-image.png?alt=media&token=73f0ea62-b0b9-46ac-aa4c-2c8c592698a7';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

/* Bianca De Los Angeles
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 200] Cart UI
  Feature Description:
    Improved UI of the shopping cart page view.
 */

class _CartPageState extends State<CartPage> {
  late Cart cart;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cart = Provider.of<Cart>(context);
    return ChangeNotifierProvider.value(
      value: cart,
      child: Scaffold(
        body: context.read<Cart>().items.isEmpty // Checks if the cart is empty
            ? const Center(
                child: Text("Cart is empty"),
              )

            //Main Content: Product Items & Cost

            : SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page Title
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 75,
                              height: 90,
                              padding: const EdgeInsets.all(9.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black, width: 1.5))),
                              child: ListTile(
                                title: Text(
                                  "Shopping Cart",
                                  style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Consumer<Cart>(
                                      builder: (context, cart, child) {
                                        return Text(
                                          "${cart.items.length}",
                                          style: GoogleFonts.lato(
                                            textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        " items in cart",
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //trailing:
                              ),
                            ),
                          )
                        ],
                      ),

                      // Item Layout
                      Expanded(
                        child: Consumer<Cart>(
                          builder: (context, cart, child) {
                            return ListView.builder(
                              itemCount: cart.items.length,
                              itemBuilder: (BuildContext context, int index) {
                                final cartItem = cart.items[index];
                                return Container(
                                  margin: const EdgeInsets.all(5),

                                  // Item Info
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 5.0),
                                      Row(children: [
                                        // Item Image
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Transform.scale(
                                            scale: 1.0,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  cartItem.item.imageUrl == null
                                                      ? NO_IMAGE_URL
                                                      : cartItem.item.imageUrl!,
                                              fit: BoxFit.cover,
                                              width: 90,
                                              height: 90,
                                            ),
                                          ),
                                        ),

                                        // Item information
                                        Flexible(
                                          child: ListTile(
                                              title: Text(cartItem.item.name),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(height: 8),
                                                  const SizedBox(height: 8),
                                                  FutureBuilder(
                                                    future: cartItem.item
                                                        .getCreator(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var creator =
                                                            snapshot.data!;
                                                        return Text(
                                                            creator.name);
                                                      } else {
                                                        return const Text(
                                                            "...");
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(height: 8),
                                                  FutureBuilder(
                                                    future: cartItem.item
                                                        .getCategory(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        var category =
                                                            snapshot.data!;
                                                        return Text(
                                                            category.name);
                                                      } else {
                                                        return const Text(
                                                            "...");
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                              trailing: Text(
                                                  '\$${cartItem.subtotal().toStringAsFixed(2)}')),
                                        ),
                                      ]),
                                      Flexible(
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cartItem.quantity++;
                                                  });
                                                },
                                                icon: const Icon(Icons.add)),
                                            Text(cartItem.quantity
                                                .toStringAsFixed(
                                                    0)), // # of items in cart
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cartItem.quantity--;
                                                  });
                                                },
                                                icon: const Icon(Icons.remove))
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      // Item Costs & Checkout
                      Container(
                        // Layout
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.black, width: 1.5))),

                        // Order Summary
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Order Summary",
                                    style: GoogleFonts.lato(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Consumer<Cart>(
                                        builder: (context, cart, child) {
                                          return Text(
                                            "Total: \$${cart.totalPrice.toStringAsFixed(2)}",
                                            style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Button to Proceed
                            Flexible(
                              flex: 3,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text("Checkout"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
      ),
    );
  }
}
