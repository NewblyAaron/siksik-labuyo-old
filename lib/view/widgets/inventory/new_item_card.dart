import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/category.dart';
import 'package:siksik_labuyo/model/creator.dart';
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

class NewItemCard extends StatelessWidget {
  const NewItemCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  // ignore: non_constant_identifier_names
  static String NO_IMAGE_URL =
      'https://firebasestorage.googleapis.com/v0/b/siksiklabuyo-d9974.appspot.com/o/images%2Fitems%2Fno-image.png?alt=media&token=73f0ea62-b0b9-46ac-aa4c-2c8c592698a7';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
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
                      item.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text('₱${item.price.toString()}')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8, top: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
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
              ),
            ),
            FutureBuilder(
              future: item.getCategory(),
              builder: (context, catSnapshot) {
                return FutureBuilder(
                  future: item.getCreator(),
                  builder: (context, creSnapshot) {
                    if (catSnapshot.hasData && creSnapshot.hasData) {
                      final category = catSnapshot.data!;
                      final creator = creSnapshot.data!;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(category.name),
                          Text(creator.name)
                        ],
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
                children: [
                  Text("x${item.stock}")
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        final category = await item.getCategory();
        final creator = await item.getCreator();

        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "[${item.id}] ${item.name}\n${category.name} | ${creator.name}")));
      },
    );
  }
}
