import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siksik_labuyo/model/category.dart';
import 'package:siksik_labuyo/model/creator.dart';

class AddItemForm extends StatefulWidget {
  const AddItemForm({super.key});

  @override
  State<AddItemForm> createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  final nameTextFormFieldController = TextEditingController();
  final priceTextFormFieldController = TextEditingController();
  final quantityTextFormFieldController = TextEditingController();

  @override
  void dispose() {
    nameTextFormFieldController.dispose();
    super.dispose();
  }

  // TODO: Refactor add_item_form.dart
  @override
  Widget build(BuildContext context) {
    String? selectedCreator;
    String? selectedCategory;

    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color:
                (MediaQuery.of(context).platformBrightness == Brightness.dark)
                    ? Colors.white
                    : theme.colorScheme.onPrimary,
          ),
          title: const Text("New item"),
        ),
        body: StreamBuilder(
          stream: creatorsRef.snapshots(),
          builder: (context, creatorSnapshot) {
            return StreamBuilder(
                stream: categoriesRef.snapshots(),
                builder: (context, categorySnapshot) {
                  if (creatorSnapshot.hasData && categorySnapshot.hasData) {
                    var creatorSnapshotData = creatorSnapshot.data!;
                    var categorySnapshotData = categorySnapshot.data!;

                    final creatorList = creatorSnapshotData.docs
                        .map((doc) => doc.data)
                        .toList();
                    final categoryList = categorySnapshotData.docs
                        .map((doc) => doc.data)
                        .toList();

                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameTextFormFieldController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Item name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter an item name!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField(
                                    hint: const Text("Creator"),
                                    isExpanded: true,
                                    value: selectedCreator,
                                    items: creatorList.map((e) {
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCreator = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please select a creator!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: DropdownButtonFormField(
                                    hint: const Text("Category"),
                                    isExpanded: true,
                                    value: selectedCategory,
                                    items: categoryList.map((e) {
                                      return DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedCategory = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please select a category!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: quantityTextFormFieldController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Quantity",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter the quantity!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    controller: priceTextFormFieldController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "Price",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter the price!";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () {
                                    print("test pick");
                                  },
                                  icon: const Icon(Icons.image_search),
                                  label: const Text("Pick an image"),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    print("test delete");
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const Text("Delete image"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final imagePicker = ImagePicker();
                                      }
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SafeArea(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                });
          },
        ));
  }
}
