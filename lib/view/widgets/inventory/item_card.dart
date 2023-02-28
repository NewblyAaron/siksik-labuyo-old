import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/item.dart';

/* 
Aaron M. Serrano
Team: i dont know
Project Name: Siksik Labuyo
Feature: [LBYO-001] Inventory
Feature description:
  A custom widget made for showing an item, it shows quick information
  of an item's name, price, and quantity, and a picture if it exists.
 */

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  // ignore: non_constant_identifier_names
  static String NO_IMAGE_URL =
      'https://firebasestorage.googleapis.com/v0/b/siksiklabuyo-d9974.appspot.com/o/images%2Fitems%2Fno-image.png?alt=media&token=73f0ea62-b0b9-46ac-aa4c-2c8c592698a7';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl:
                    (item.imageUrl == null) ? NO_IMAGE_URL : item.imageUrl!,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ColoredBox(
                  color: Colors.black.withAlpha(128),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const Padding(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0)),
                            Text('x${item.stock.toString()}',
                                style: const TextStyle(color: Colors.amber)),
                          ],
                        ),
                        Text('₱${item.price.toString()}',
                            style: const TextStyle(
                                color: Colors.greenAccent, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "[${item.id}] ${item.name}\n${item.categoryId}\n${item.creatorId}")));
      },
    );
  }
}
