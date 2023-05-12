import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siksik_labuyo/model/item.dart';
import 'package:siksik_labuyo/view/pages/pos/pos_cart_page.dart';

/*
  Aaron Serrano
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 403.1] Items Card Widget
  Feature Description:
    The items card widget for use in the items tabview.
 */

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  // ignore: non_constant_identifier_names
  static String NO_IMAGE_URL =
      'https://firebasestorage.googleapis.com/v0/b/siksiklabuyo-d9974.appspot.com/o/images%2Fitems%2Fno-image.png?alt=media&token=73f0ea62-b0b9-46ac-aa4c-2c8c592698a7';

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int quantity = 1;
  late TextEditingController qtyField;

  @override
  void initState() {
    super.initState();
    qtyField = TextEditingController(text: quantity.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.item.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('₱${widget.item.price.toString()}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 8, top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: (widget.item.imageUrl == null)
                        ? ItemCard.NO_IMAGE_URL
                        : widget.item.imageUrl!,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      );
                    },
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
            ),
            FutureBuilder(
                future: widget.item.getCategory(),
                builder: (context, catSnapshot) {
                  return FutureBuilder(
                    future: widget.item.getCreator(),
                    builder: (context, creSnapshot) {
                      if (catSnapshot.hasData && creSnapshot.hasData) {
                        final category = catSnapshot.data!;
                        final creator = creSnapshot.data!;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [Text(category.name), Text(creator.name)],
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: LinearProgressIndicator(),
                          ),
                        );
                      }
                    },
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(right: 8, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Text("x${widget.item.stock}")],
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
          var result = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Please enter the quantity"),
              content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      quantity--;
                      qtyField.text = quantity.toString();
                    });
                  },
                  child: const Text("-")),
              SizedBox(
                width: 32,
                child: TextField(
                  decoration: const InputDecoration(hintText: "#"),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: qtyField,
                  onEditingComplete: () {
                    setState(() {
                      if (qtyField.text.isNotEmpty) {
                        setState(() {
                          quantity = int.parse(qtyField.text);
                        });
                      }
                    });
                  },
                ),
              ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                      qtyField.text = quantity.toString();
                    });
                  },
                  child: const Text("+")),
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    CartItem ci = CartItem(item: widget.item, quantity: quantity);
                    Navigator.pop(context, ci);
                  },
                  child: const Text("Add to Cart")),
            ],
          ),
        );

        if (result != null) {
          setState(() {
            
          });
        }
      },
    );
  }
}
