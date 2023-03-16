import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/creator.dart';
import 'package:siksik_labuyo/view/pages/inventory/form/edit_creator_form.dart';

/*
  Aaron Serrano
  Team: IDK
  Project: Siksik Labuyo
  Feature: [LBYO - 401.1] Creators Card Widget
  Feature Description:
    The creators card widget for use in the creators tabview.
 */

class CreatorCard extends StatelessWidget {
  const CreatorCard({Key? key, required this.creator}) : super(key: key);

  final Creator creator;

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
                  creator.name,
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

      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => EditCreatorForm(key: key, creator: creator)),
        );
      },
    );
  }
}
