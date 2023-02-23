import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/category.dart';

class EditCategoryForm extends StatefulWidget {
  const EditCategoryForm({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  State<EditCategoryForm> createState() => _EditCategoryFormState();
}

class _EditCategoryFormState extends State<EditCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final nameTextFormFieldController = TextEditingController();

  @override
  void dispose() {
    nameTextFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    nameTextFormFieldController.text = widget.category.name;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Delete creator"),
                content: Text(
                    "Are you sure you want to delete ${widget.category.name}?"),
                actions: [
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () async {
                      final db = FirebaseFirestore.instance;
                      final docRef =
                          db.collection('categories').doc(widget.category.id);

                      await docRef
                          .delete()
                          .then((doc) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${widget.category.name} has been deleted!')));
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          })
                          .timeout(const Duration(seconds: 15))
                          .catchError((error) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text('An error has occured...\n\n$error')));
                          });
                    },
                  ),
                  TextButton(
                    child: const Text("No"),
                    onPressed: () {
                      // do nothing, just close the dialog
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
        title: const Text("Edit category"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameTextFormFieldController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text!';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing data...')));
                            var db = FirebaseFirestore.instance;

                            final updatedCategory = Category(
                                name: nameTextFormFieldController.text,
                                id: widget.category.id);
                            final docRef = db
                                .collection('categories')
                                .doc(updatedCategory.id);

                            await docRef
                                .update(updatedCategory.toFirestore())
                                .then((doc) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Success! ${widget.category.name} is updated to ${updatedCategory.name}!')));
                                  Navigator.pop(context);
                                })
                                .timeout(const Duration(seconds: 15))
                                .catchError((error) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'An error has occured...\n\n$error')));
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
