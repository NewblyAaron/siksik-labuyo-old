import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/category.dart';
import 'package:siksik_labuyo/view/pages/inventory/form/edit_category_form.dart';

/*
  Aaron Serrano
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 402.1] Categories Card Widget
  Feature Description:
    The categories card widget for use in the categories tabview.
 */

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GestureDetector(
      child: Card(
        color: theme.colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  category.name,
                  style: TextStyle(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontSize: 18,
                  )
                ),
              ),
            ],
          ),
        ),
      ),

      onTap:() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditCategoryForm(category: category)),
        );
      },
    );
  }
}
