// Define a custom Form widget.
import 'package:flutter/material.dart';

class TodoForm extends StatefulWidget {
  final Function(String) onFormSubmit;
  const TodoForm({super.key, required this.onFormSubmit});

  @override
  TodoFormState createState() {
    return TodoFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class TodoFormState extends State<TodoForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<TodoFormState>.
  final valueText = TextEditingController();
  String value = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Material(
        child: Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
              controller: valueText,
              onChanged: (value) {
                this.value = value;
              },
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              }),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
              widget.onFormSubmit(this.value);
              valueText.clear();
            },
            child: const Text('Submit'),
          ),
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    ));
  }
}
