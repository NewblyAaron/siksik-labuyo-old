import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/creator.dart';

class EditCreatorForm extends StatefulWidget {
  const EditCreatorForm({Key? key, required this.creator}) : super(key: key);

  final Creator creator;

  @override
  State<EditCreatorForm> createState() => _EditCreatorPageState();
}

class _EditCreatorPageState extends State<EditCreatorForm> {
  final _formKey = GlobalKey<FormState>();
  final nameTextFormFieldController = TextEditingController();

  @override
  void dispose() {
    nameTextFormFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    nameTextFormFieldController.text = widget.creator.name;

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
                    "Are you sure you want to delete ${widget.creator.name}?"),
                actions: [
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () async {
                      await creatorsRef
                          .doc(widget.creator.id)
                          .delete()
                          .then((doc) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${widget.creator.name} has been deleted!')));
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
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
        title: const Text("Edit creator"),
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
                  hintText: 'Creator name',
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
                            final updatedCreator = Creator(
                                name: nameTextFormFieldController.text,
                                id: widget.creator.id);
                            await creatorsRef
                                .doc(widget.creator.id)
                                .update(name: updatedCreator.name)
                                .then((doc) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Success! ${widget.creator.name} is updated to ${updatedCreator.name}!')));
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
