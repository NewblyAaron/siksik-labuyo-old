import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siksik_labuyo/model/item.dart';

class CartItem {
  // final String image;
  // final String name;
  // final String description;
  // final double price;
  // final int quantity;
  // CartItem({required this.image, required this.name, required this.description, required this.price, required this.quantity});

  final ItemDocumentReference itemDocRef;
  int quantity;

  CartItem({required this.itemDocRef, required this.quantity});
}

// List of items in cart
List<CartItem> cartItems = [
  CartItem(itemDocRef: itemsRef.doc("anya"), quantity: 2)
  // CartItem(
  //   image: 'https://images.pexels.com/photos/8329269/pexels-photo-8329269.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //   name: 'Bergamot Tea Leaves',
  //   description: 'Product A description',
  //   price: 10.99, quantity: 3,
  // ),
  // CartItem(
  //   image: 'https://images.pexels.com/photos/2062324/pexels-photo-2062324.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //   name: 'Watercolor T-shirt',
  //   description: 'Product B description',
  //   price: 19.99, quantity: 4,
  // ),
  // CartItem(
  //     image: 'https://images.pexels.com/photos/872902/pexels-photo-872902.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     name: '2nd-hand French Press',
  //     description: 'Product C description',
  //     price: 7.50, quantity: 5),
  // CartItem(
  //     image: 'https://images.pexels.com/photos/6397725/pexels-photo-6397725.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     name: 'Pikachu Plush',
  //     description: 'Product C description',
  //     price: 7.50, quantity: 5),
  // CartItem(
  //     image: 'https://images.pexels.com/photos/9981595/pexels-photo-9981595.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     name: 'Gold Rolex Watch Ver123',
  //     description: 'Product C description',
  //     price: 7.50, quantity: 5),
  // CartItem(
  //     image: 'https://images.pexels.com/photos/9587440/pexels-photo-9587440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     name: 'Golden Flower Tote Bag',
  //     description: 'Product C description',
  //     price: 7.50, quantity: 5),
  // CartItem(
  //     image: 'https://images.pexels.com/photos/5433851/pexels-photo-5433851.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  //     name: 'Carved Truck',
  //     description: 'Product C description',
  //     price: 7.50, quantity: 5),
];

String NO_IMAGE_URL =
    'https://firebasestorage.googleapis.com/v0/b/siksiklabuyo-d9974.appspot.com/o/images%2Fitems%2Fno-image.png?alt=media&token=73f0ea62-b0b9-46ac-aa4c-2c8c592698a7';

class PointOfSalePage extends StatefulWidget {
  const PointOfSalePage({super.key});

  @override
  State<PointOfSalePage> createState() => _PointOfSalePageState();
}

/* Bianca De Los Angeles
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 200] Cart UI
  Feature Description:
    Improved UI of the shopping cart page view.
 */

class _PointOfSalePageState extends State<PointOfSalePage> {
  Future<double> calculateSubtotal() async {
    double subtotal = 0.0;
    for (CartItem ci in cartItems) {
      var item = await ci.itemDocRef.get().then((value) => value.data!);
      subtotal += item.price * ci.quantity;
    }
    return subtotal;
  }

  Future<double> calculateTax() async {
    // Assume 10% tax rate
    double taxRate = 0.1;
    return await calculateSubtotal() * taxRate;
  }

  Future<double> calculateTotal() async {
    return await calculateSubtotal() + await calculateTax();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int numItems = cartItems.length;

    return Scaffold(
      body: cartItems.isEmpty // Checks if the cart is empty
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
                              Text(
                                "$numItems",
                                style: GoogleFonts.lato(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
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
                  child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (BuildContext context, int index) {
                        final cartItem = cartItems[index];
                        return FutureBuilder(
                          future: cartItem.itemDocRef.get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final item = snapshot.data!.data!;
                              // For Each Item
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
                                            imageUrl: item.imageUrl == null
                                                ? NO_IMAGE_URL
                                                : item.imageUrl!,
                                            fit: BoxFit.cover,
                                            width: 90,
                                            height: 90,
                                          ),
                                        ),
                                      ),

                                      // Item information
                                      Flexible(
                                        child: ListTile(
                                            title: Text(item.name),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 8),
                                                const SizedBox(height: 8),
                                                FutureBuilder(
                                                  future: item.getCreator(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      var creator =
                                                          snapshot.data!;
                                                      return Text(creator.name);
                                                    } else {
                                                      return const Text("...");
                                                    }
                                                  },
                                                ),
                                                const SizedBox(height: 8),
                                                FutureBuilder(
                                                  future: item.getCategory(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      var category =
                                                          snapshot.data!;
                                                      return Text(
                                                          category.name);
                                                    } else {
                                                      return const Text("...");
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                            trailing: Text(
                                                '\$${(item.price * cartItem.quantity).toStringAsFixed(2)}')),
                                      ),
                                    ]),
                                    Flexible(
                                      child: Flex(
                                        direction: Axis.horizontal,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // TODO: Functionality on Adding & Subtracting Items
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
                            } else {
                              return Container(
                                  margin: const EdgeInsets.all(5),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ));
                            }
                          },
                        );
                      }),
                ),

                // Item Costs & Checkout
                Container(
                  // Layout
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.black, width: 1.5))),

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

                      // Total Cost
                      FutureBuilder(
                          future: calculateSubtotal(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            return Flexible(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Total: \$${snapshot.data!.toStringAsFixed(2)}",
                                        style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

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
              ],
            )),
    );
  }
}
