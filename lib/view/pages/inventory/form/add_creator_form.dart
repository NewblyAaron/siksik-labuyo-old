import 'package:flutter/material.dart';
import 'package:siksik_labuyo/model/creator.dart';

class AddCreatorForm extends StatefulWidget {
  const AddCreatorForm({super.key});

  @override
  State<AddCreatorForm> createState() => _AddCreatorFormState();
}

class _AddCreatorFormState extends State<AddCreatorForm> {
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
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: (MediaQuery.of(context).platformBrightness == Brightness.dark)
              ? Colors.white
              : theme.colorScheme.onPrimary,
        ),
        title: const Text("New creator"),
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
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Processing data...')));

                          final newCreator =
                              Creator(name: nameTextFormFieldController.text);
                          creatorsRef
                              .add(newCreator)
                              .then((value) async {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Success! ${newCreator.name} is added.')));
                                Navigator.pop(context);
                              })
                              .timeout(const Duration(seconds: 15))
                              .catchError((error) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'An error has occured... $error')));
                              });
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
      ),
    );
  }
}
